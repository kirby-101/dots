#!/usr/bin/env bash

pub_ip=$(fetch -qo - 'https://wtfismyip.com/text')
pub_host=$(host ${pub_ip} |  awk '/domain name pointer/ {print $5}')

if [ -n "$pub_host" ]; then
    echo $pub_host
else
    echo "$pub_ip"
fi
