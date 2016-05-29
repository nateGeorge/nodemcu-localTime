# nodemcu-localTime
syncs with the internet to get local time

use like this:

localTime = {}
dofile('get local time.lua')
tmr.alarm(1,5000,0,function() print(localTime.hour) end) -- need to give it a bit to grab the time from google

inspired by this post:
http://thearduinoguy.org/using-an-esp8266-as-a-time-source-part-2/

there's also this:
http://www.esp8266.com/viewtopic.php?p=8733

but this one is the best:
https://github.com/wogum/esp01/blob/master/ntp.lua

which is where I got the ntp.lua file from
