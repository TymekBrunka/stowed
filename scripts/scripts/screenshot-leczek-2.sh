if [ ! -f /opt/lampp/htdocs/import.jpeg ]; then
    grim -t jpeg /opt/lampp/htdocs/import.jpeg
else
    grim -t png /opt/lampp/htdocs/kw$(($(ls -1 /opt/lampp/htdocs/ | grep kw[1-9] -I | wc -l) + 1)).png
fi
