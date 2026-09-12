# MikroTik RouterOS - Backup
#
# Creates a backup file using:
# - Router identity
# - Current date
# - RouterOS version

/system/script/add name=RouterOS_backup source={
    :local RouterIdentity [/system/identity/get name]
    :local Date [/system/clock/get date]
    :local OSVersion [/system/resource/ get version]

    :local FileName "$RouterIdentity_$Date_RouterOS-$OSVersion-backup"

    /system/backup/save name=$FileName
}
