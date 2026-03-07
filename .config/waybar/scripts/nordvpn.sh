#!/bin/bash

STATUS=$(nordvpn status | grep -i "Status:" | awk '{print $2}')
COUNTRY=$(nordvpn status | grep -i "Country:" | awk '{$1=""; print $0}' | xargs)

if [ "$STATUS" = "Connected" ]; then
	echo "{\"text\": \"NordVPN 󰦝 \", \"tooltip\": \"NordVPN: Connected to $COUNTRY\", \"class\": \"connected\"}"
else
	echo "{\"text\": \"NordVPN 󰦞 \", \"tooltip\": \"NordVPN: Disconnected\", \"class\": \"disconnected\"}"
fi
