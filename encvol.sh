#!/usr/bin/env bash
set -euf -o pipefail  # Makes bash behave sanely, see https://sipb.mit.edu/doc/safe-shell/

# This script makes it easy to create an encrypted APFS volume. It generates a
# secure passphrase, creates the volume, and stores the passphrase in the
# system keychain so that the volume can be automatically decrypted and mounted
# on boot. We intentionally do not store the volume password in the user's
# keychain because that keychain may get deleted by password rotation.


txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtrst='\e[0m'    # Text Reset

function msg {
    printf "$*$txtrst\n" 1>&2
}

usage="Usage: $0 <volume_name> [-quota 50g]"
[[ $# -lt 1 ]] && { msg "Volume name must be specified. $usage"; exit 1; }

volume_name="$1"
shift

vol_quota=""
while :; do
    case ${1-} in
        -quota)
            if [[ $# -eq 2 ]]; then
                vol_quota="-quota $2"
                msg "Quota for volume $volume_name will be: $2"
                shift
            else
                msg "You must specify exactly one argument to -quota. $usage"
                exit 1
            fi
            ;;
        -?*)
            msg "Unknown option: $1"
            msg "$usage"
            exit 1
            ;;
        *)
            break
    esac

    shift
done

volume_passphrase="$(dd if=/dev/urandom bs=64 count=1 2>/dev/null | base64 | tr -d '\n')"
/usr/sbin/diskutil apfs addVolume disk1 'Case-sensitive APFS' $volume_name -stdinpassphrase $vol_quota <<< "$volume_passphrase"

vol_info_file="/tmp/$volume_name.plist"
/usr/sbin/diskutil info -plist "$volume_name" > "$vol_info_file" || { echo "Wrong volume: \"$volume_name\". Exiting."; exit 1; }
vol_uuid="$(/usr/libexec/PlistBuddy -c 'Print VolumeUUID' "$vol_info_file")"
vol_mountPoint="$(/usr/libexec/PlistBuddy -c 'Print MountPoint' "$vol_info_file")"
rm "$vol_info_file"

system_keychain_path="$(security list-keychains -d system | head -1 | sed -E 's/[ ]+\"(.*)\"/\1/')"

msg $txtylw"We need to briefly run as root (through sudo) to store the volume
passphrase in the System keychain ($system_keychain_path) to protect it from
deletion during password rotation. If prompted, please enter your user password."

# We MUST use the interactive mode of security to add the passphrase. Without
# it the passphrase would be passed as an argument which is insecure.
# Also, the passphrase must be stored in the system keychain and not login
# keychain. Some people choose to delete their login keychains during password
# rotation.
sudo /usr/bin/security -i <<EOF
add-generic-password -a "$vol_uuid" -s "$vol_uuid" -D "Encrypted Volume Password" -l "$volume_name" \
-U -T "/System/Library/CoreServices/APFSUserAgent" -T "/Applications/Utilities/Disk Utility.app" -T "/System/Library/CoreServices/CSUserAgent" -T "/usr/bin/security" \
-w "$volume_passphrase" "$system_keychain_path"
EOF

msg $txtgrn"Volume passphrase has been stored in the System keychain ($system_keychain_path).
Password rotation process doesn't delete System keychain but it's not a bad idea to back up the volume passphrase in your password safe."
msg "Your volume password is: $volume_passphrase"
msg $txtgrn"Encrypted volume $volume_name (UUID $vol_uuid) was successfully created and mounted in \"$vol_mountPoint\"."


