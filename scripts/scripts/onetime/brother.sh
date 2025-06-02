sudo pacman -S cups
sudo systemctl enable cups --now
paru -S brother-dcpj105
sudo pacman -S system-config-printer gutenprint

# http://localhost:631
# > administration
# > add printer
# > internet printing protocol (ipp)
# ipp://192.168.8.105/ipp/port1
# drivers directory (from makepkg -o): /opt/brother/Printers/dcpj105/cupswrapper/brother_dcpj105_printer_en.ppd
