#! /bin/bash

city=Casablanca
obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*')
echo "the current temperature of $city: $obs_temp"

fc_temp=$(curl -s wttr.in/$city?T | head -n 23 | tail -n 1 grep -m 1 '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digital:]].*')
echo "the forecasted temperature for nooon tomorrow for $city : $fc_temp C"

TZ='Morocco/Casablanca'
# Use command substitution to store the current day, month, and year in corresponding shell variables:
day=$(TZ='Morocco/Casablanca' date -u +%d) 
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp C")
echo $record>>rx_poc.log