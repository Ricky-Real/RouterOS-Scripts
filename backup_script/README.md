# RouterOS Backup Script

A RouterOS script that automatically creates a backup file
with the router identity, current date and RouterOS version
included in the filename.

## Features

- Automatically detects router identity
- Adds the current date to the filename
- Adds the RouterOS version
- Creates a `.backup` file automatically

## Example

The script can generate a filename such as:

MikroTik_2026-09-12_RouterOS-7.19.1-backup.backup

## Requirements

- MikroTik RouterOS 7.x
- Permission to create system backups

## Installation

Upload `RouterOS_backup.rsc` to the MikroTik router.

Then import it:

```routeros
/import RouterOS_backup.rsc
```
## Usage

```routeros
/system/script/run RouterOS_backup
```