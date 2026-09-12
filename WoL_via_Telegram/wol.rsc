# MikroTik RouterOS - Telegram Wake-on-LAN
#
# Monitors Telegram for a specific message and sends
# a Wake-on-LAN packet when the message is received.

/system/script/add name=wol source={
    :local botToken "Place your Telegram bot token here"
    :local chatID "Place your Telegram chat id here"
    :local macAddress "Place the MAC address of the device which you want to send a WoL packet to";
    # Message that executes WoL, default is "pc"
    :local wakePhrase "pc" 
    :local RouterIdentity [/system/identity/get name]
    :local urlSend "https://api.telegram.org/bot$botToken/sendmessage?chat_id=$chatID&text=$RouterIdentity:"
    :local urlUpdate "https://api.telegram.org/bot$botToken/getUpdates?offset=-1"
    :global previousUpdateID 
    :if ([:typeof $previousUpdateID] = "nothing") do={
        :set previousUpdateID 0
    }
    :local updateID 

    :local data 
    :do {
        :set data ([/tool fetch url=$urlUpdate as-value output=user]->"data")
    } on-error={
        :delay 3000ms;
        :log warning "Telegram tool fetch url error"
        :return 0
    }

    :local JSON [ :deserialize from=json value=$data ];
    :local Update (($JSON->"result")->0)
    :set updateID ($Update->"update_id");
    :local Message 
    :if ([:typeof ($Update->"message")] != "nothing") do={
        :set Message ($Update->"message");
        } else={
            :if ([:typeof ($Update->"channel_post")] != "nothing") do={
                :set Message ($Update->"channel_post");
            } else={
                :set Message {"text"="0"}
                }
        }
    :local text ($Message->"text");
    :if (($updateID > $previousUpdateID) && ($previousUpdateID != 0)) do={ 
        :if ($text = $wakePhrase) do={
            /tool wol mac=$macAddress
            /tool fetch url=($urlSend . "+Turning+the+device+on") keep-result=no
            :log info "WoL triggered"
            } 
    } 
    :set previousUpdateID $updateID
}
