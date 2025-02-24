while true; do
	bat=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "percentage" | awk '{print $2}')
	datetime=$(date '+%R %A %-d %B %Y')
#	echo "$bat 󰁿 | $datetime"
	xsetroot -name "$bat 󰁿 | $datetime"
	sleep 1 
done
