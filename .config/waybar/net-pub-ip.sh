#!/usr/bin/env bash
pub_ip=$(host $(fetch -qo - 'https://wtfismyip.com/text')  | awk '/domain name pointer/ {print $5}')

if [ -n "$pub_ip" ]; then
    echo $pub_ip
else
    echo "offline"
fi





