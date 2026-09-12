:log info message="Shutting down in a few seconds"
:local botToken "Place your Telegram bot token here, leave blank if you don't want to use it"
:local chatID "Place your Telegram chat id here, leave blank if you don't want to use it"
:local RouterIdentity [/system/identity/get name]
:local urlSend "https://api.telegram.org/bot$botToken/sendmessage?chat_id=$chatID&text=$RouterIdentity:"

:do {
    tool fetch url=(urlSend . "+Mode+Button:+Shutdown+requested") keep-result=no 
    :delay 500ms
    /tool fetch url=(urlSend . "+Shutting+down+in+a+few+seconds.") keep-result=no
    :delay 500ms 
    /system shutdown
} on-error= {
    /system/shutdown 
}

