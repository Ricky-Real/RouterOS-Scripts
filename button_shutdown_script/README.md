# RouterOS Mode Button Shutdown

A MikroTik RouterOS script that shuts down
the router when triggered by the RouterBOARD Mode Button.

The script can optionally send Telegram notifications before shutting down.

## Features

- Uses the physical RouterBOARD Mode Button
- Sends optional Telegram notifications
- Includes the router identity in notifications
- Shuts down the router automatically
- Continues with the shutdown if Telegram notification fails

## Requirements

- MikroTik RouterOS 7.x
- A RouterBOARD device with a configurable Mode Button
- Optional Telegram bot

## Configuration

Upload `RouterOS_button_shutdown.rsc` to the MikroTik router.

Then import it:

```routeros
/import RouterOS_button_shutdown.rsc
```

Set the Mode button to execute the script:

```routeros
/system/routerboard/mode-button/set enabled=yes hold-time=0..3 on-event=RouterOS_button_shutdown
```
This enables the Mode button and the script only executes 
when you hold the button between 0 and 3 seconds. 

### OPTIONAL

Configure the following variables if you want to use Telegram notifications:

```routeros
/system/script/edit RouterOS_button_shutdown.rsc
value-name: source
```
edit 
```routeros
:local botToken "XXXXXXXXXX:XXXXXXXXXXX_XXXXXXX-XXXXXXXXXXXXXXX"
:local chatID "XXXXXXXXXX"
```
Press `CTRL+O` to save.

**Security:** Never publish your real Telegram bot token in a public repository.

## Additional Resources

For further instructions check [MikroTik's video](https://www.youtube.com/watch?v=KLX6j3sLRIE).
