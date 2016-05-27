microSecElapsed = tmr.now() - timeAtSync

-- do some math to get current time

hourElapsed = microSecElapsed / (60 * 60 * 1000000)
if hourElapsed > 1 then
    localTime.hour = localTime.hour + math.floor(hourElapsed)
    while localTime.hour > 24 do
        localTime.day = localTime.day + 1
        localTime.hour = localTime.hour - 24
    end
    hourRemain = hourElapsed - math.floor(hourElapsed)
    minElapsed = hourRemain * 60
else
    minElapsed = microSecElapsed / (60 * 1000000)
end


if minElapsed > 1 then
    localTime.minute = localTime.minute + math.floor(minElapsed)
    minRemain = minElapsed - math.floor(minElapsed)
    secElapsed = minRemain * 60
else
    secElapsed = microSecElapsed / (1000000)
end


if secElapsed > 1 then
    print('secElapsed = '..secElapsed)
    localTime.second = localTime.second + math.floor(secElapsed)
    secRemain = secElapsed - math.floor(secElapsed)
    usElapsed = secRemain * 1000000
else
    usElapsed = microSecElapsed
end


localTime.us = localTime.us + usElapsed

timeAtSync = tmr.now()

print('local time: '..localTime.month..' '..localTime.day..', '..localTime.hour..':'..localTime.minute..':'..localTime.second)