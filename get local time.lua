-- retrieve the current time from Google
-- tested on NodeMCU 0.9.5 build 20150213

function invert_table(t)
   local s={}
   for k,v in pairs(t) do
     s[v]=k
   end
   return s
end

--localTime = {} -- month, day, hour, minute, second

monthTable = {
["Jan"] = 1, ["Feb"] = 2, ["Mar"] = 3, ["Apr"] = 4, ["May"] = 5, ["Jun"] = 6, ["Jul"] = 7, ["Aug"] = 8, ["Sep"] = 9, ["Oct"] = 10, ["Nov"] = 11, ["Dec"] = 12}
invertedMonth = invert_table(monthTable)

conn=net.createConnection(net.TCP, 0) 
 
conn:on("connection",function(conn, payload)
            conn:send("HEAD / HTTP/1.1\r\n".. 
                      "Host: google.com\r\n"..
                      "Accept: */*\r\n"..
                      "User-Agent: Mozilla/4.0 (compatible; esp8266 Lua;)"..
                      "\r\n\r\n") 
            end)
            
conn:on("receive", function(conn, payload)
    --print(payload)
    conn:close()
    GMtime = string.sub(payload,string.find(payload,"Date: ")
           +6,string.find(payload,"Date: ")+35)
    year = tonumber(string.sub(GMtime, 13, 16))
    month = monthTable[string.sub(GMtime, 9, 11)];
    day = tonumber(string.sub(GMtime, 6, 7))
    hour = tonumber(string.sub(GMtime, 18, 19))
    minute = tonumber(string.sub(GMtime, 21, 22))
    second = tonumber(string.sub(GMtime, 24, 25))
    -- account for daylight savings time, this is for mountain time
    if (month>2 or month<11) then
        hourSubtract = 6
    else
        hourSubtract = 7
    end
    if (hour<hourSubtract) then
        day = day - 1
        hour = hour + 24
    end
    hour = hour - hourSubtract
    print('Google Time: '..string.sub(payload,string.find(payload,"Date: ")
           +6,string.find(payload,"Date: ")+35))
    print('local time: '..invertedMonth[month]..' '..day..', '..hour..':'..minute..':'..second)
    localTime.year = year
    localTime.month = invertedMonth[month]
    localTime.monthNumber = month
    localTime.day = day
    localTime.hour = hour
    localTime.minute = minute
    localTime.second = second
end)
t = tmr.now()    
conn:connect(80,'google.com')
