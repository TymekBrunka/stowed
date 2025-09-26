sudo powertop --auto-tune
sleep 1
sudo echo "on" >> /sys/bus/usb/devices/3-5/power/control
