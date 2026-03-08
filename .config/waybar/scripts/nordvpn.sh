#!/bin/bash

# Single call, with timeout protection
STATUS_OUTPUT=$(timeout 5 nordvpn status 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$STATUS_OUTPUT" ]; then
    echo '{"text": "󰦞 ", "tooltip": "NordVPN: Error", "class": "error"}'
    exit 0
fi

STATUS=$(echo "$STATUS_OUTPUT" | grep -i "Status:" | awk '{print $2}')
COUNTRY=$(echo "$STATUS_OUTPUT" | grep -i "Country:" | awk '{$1=""; print $0}' | xargs)

# Escape country name for safe JSON embedding
COUNTRY=$(echo "$COUNTRY" | sed 's/\\/\\\\/g; s/"/\\"/g')

if [ "$STATUS" = "Connected" ]; then
    echo "{\"text\": \"󰦝 \", \"tooltip\": \"NordVPN: Connected to $COUNTRY\", \"class\": \"connected\"}"
else
    echo "{\"text\": \"󰦞 \", \"tooltip\": \"NordVPN: Disconnected\", \"class\": \"disconnected\"}"
fi
