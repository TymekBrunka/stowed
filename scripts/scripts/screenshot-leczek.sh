if [ ! -f /opt/lampp/htdocs/import.png ]; then
    grim /opt/lampp/htdocs/import.png
else
    grim -t jpeg /opt/lampp/htdocs/kw$(($(ls -1 /opt/lampp/htdocs/ | grep kw[1-9] -I | wc -l) + 1)).jpeg
fi
