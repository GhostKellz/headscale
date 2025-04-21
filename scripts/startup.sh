#!/bin/sh

# Start Headscale in background
headscale serve &

# Wait a bit to allow DB to init
sleep 3

# Generate API key if file doesn't exist
if [ ! -f /etc/headscale/headscale_api_key.txt ]; then
    headscale apikeys create --expiration 8760h --reusable > /etc/headscale/headscale_api_key.txt
fi

# Keep container alive
wait
