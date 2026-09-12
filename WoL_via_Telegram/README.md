# Telegram Wake-on-LAN

A MikroTik RouterOS script that monitors a Telegram bot for a specific message and sends a Wake-on-LAN (WoL) packet to a configured device.

When the configured wake phrase is received, the router sends a WoL packet and logs the event in the RouterOS log.

## Features

* Sends Wake-on-LAN packets using MikroTik RouterOS
* Uses Telegram as a remote WoL trigger
* Configurable wake phrase
* Configurable target MAC address
* Sends a Telegram notification after triggering WoL
* Logs WoL events in the RouterOS log
* Stores the last processed Telegram update ID to avoid processing the same message repeatedly

## Requirements

* MikroTik RouterOS 7.x
* Internet access from the MikroTik router
* A Telegram bot
* The MAC address of the device you want to wake
* Wake-on-LAN enabled on the target device

## Installation

Upload `wol.rsc` to the MikroTik router.

Import the script:

```routeros
/import wol.rsc
```

This creates a RouterOS System Script named `wol`.

## Configuration

Before using the script, edit the following variables in the `wol.rsc` file:

```routeros
:local botToken "Place your Telegram bot token here"
:local chatID "Place your Telegram chat id here"
:local macAddress "Place the MAC address of the device which you want to send a WoL packet to"
```

Replace the placeholders with your own values.

The default wake phrase is:

```routeros
:local wakePhrase "pc"
```

You can change `pc` to any message you want to use as the WoL trigger.

For example:

```routeros
:local wakePhrase "wake"
```

## Running the Script

The script should be executed periodically using the RouterOS Scheduler so that it can continuously check Telegram for new messages.

Example:

```routeros
/system/scheduler/add name=telegram-wol interval=5s on-event=wol
```

This runs the `wol` script every 5 seconds.

You can adjust the interval depending on how quickly you want Telegram commands to be detected.

## Usage

Send the configured wake phrase to your Telegram bot.

For example, with the default configuration:

```text
pc
```

The router will:

1. Check the Telegram message.
2. Verify that it is a new message.
3. Compare the message with the configured wake phrase.
4. Send a Wake-on-LAN packet to the configured MAC address.
5. Write a WoL event to the RouterOS log.
6. Send a confirmation message through Telegram.

## RouterOS Log

When WoL is triggered, the script writes:

```text
WoL triggered
```

to the RouterOS log.

You can view it with:

```routeros
/log/print
```

The values in the example configuration are placeholders:

```routeros
:local botToken "Place your Telegram bot token here"
:local chatID "Place your Telegram chat id here"
:local macAddress "Place the MAC address of the device which you want to send a WoL packet to";

```

**Security:** Never publish your real Telegram bot token in a public repository.

## Additional Resources

For further instructions check [MikroTik's video](https://www.youtube.com/watch?v=KLX6j3sLRIE).