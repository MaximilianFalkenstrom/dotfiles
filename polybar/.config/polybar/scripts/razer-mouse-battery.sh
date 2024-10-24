#!/bin/sh

battery=$(razer-cli --battery print | grep charge | grep -oP "([0-9])+")
dpi=$(razer-cli --dpi print)

if [[ dpi -eq 0 ]]; then
    echo "off"
elif razer-cli --battery print | grep charging | grep -oqP "(True)+"; then
    echo "$battery% - charging"
else
    echo "$battery%"
fi