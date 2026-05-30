#!/bin/bash

# Configuration
TVH_HOST="pitvheadend2"
TVH_HOST="localhost"
TVH_PORT="9981"
TVH_USER="your_username"  # Change to your TVheadend username
TVH_PASS="your_password"  # Change to your TVheadend password

# Max attempts (12 tries * 5 minutes = 60 minutes max wait time)
MAX_ATTEMPTS=12
ATTEMPT=1

while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    # Fetch the number of active recordings via TVheadend API
    #ACTIVE_RECS=$(curl -s -u "$TVH_USER:$TVH_PASS" "http://$TVH_HOST:$TVH_PORT/api/dvr/entry/grid?state=recording" | grep -o '"total": [0-9]*' | awk '{print $2}')
    #ACTIVE_RECS=$(curl -s  "http://$TVH_HOST:$TVH_PORT/api/dvr/entry/grid?state=recording" | grep -o '"total": [0-9]*' | awk '{print $2}')
    #curl -s  "http://$TVH_HOST:$TVH_PORT/api/status/subscriptions" | jq '[.entries[] | select((.title != "epggrab") and (.title | contains("Kodi Media Cent") | not))] | length'
    ACTIVE_RECS=$(curl -s  "http://$TVH_HOST:$TVH_PORT/api/status/subscriptions" | jq '[.entries[] | select((.title != "epggrab") and (.title | contains("Kodi Media Cent") | not))] | length')

    # If API fails, log it, wait 5 mins, and try again
    if [[ ! "$ACTIVE_RECS" =~ ^[0-9]+$ ]]; then
        echo "$(date): Error: Could not connect to TVheadend API. Attempt $ATTEMPT/$MAX_ATTEMPTS." >> /var/log/tvh_reboot.log
    
    # If no recordings are active, reboot immediately
    elif [ "$ACTIVE_RECS" -eq 0 ]; then
        echo "$(date): Success: No active recordings. Rebooting system now..." >> /var/log/tvh_reboot.log
        /sbin/shutdown -r now
        exit 0
    
    # If actively recording, log it
    else
        echo "$(date): TVheadend is actively recording $ACTIVE_RECS show(s). Attempt $ATTEMPT/$MAX_ATTEMPTS." >> /var/log/tvh_reboot.log
    fi

    # Check absolute system uptime. If uptime is approaching 25 hours (90000 seconds), force reboot anyway
    UPTIME_SECONDS=$(awk '{print int($1)}' /proc/uptime)
    if [ "$UPTIME_SECONDS" -gt 88200 ]; then  # 24.5 hours
        echo "$(date): WARNING: Uptime is reaching 25 hours. Not forcing reboot despite active recordings!" >> /var/log/tvh_reboot.log
        #/sbin/shutdown -r now
        exit 0
    fi

    # Wait 5 minutes before looping again
    sleep 300
    ATTEMPT=$((ATTEMPT + 1))
done

# If the loop finishes, it means we hit the 60-minute limit (it is now 6:00 AM)
#echo "$(date): FORCE REBOOT: Wait window expired (60 mins). Forcing reboot now." >> /var/log/tvh_reboot.log
#/sbin/shutdown -r now
