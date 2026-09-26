#!/usr/bin/env bash
ifconfig $(route -n get default | awk '/interface:/ {print $2}') | grep 'inet' | awk -F ' ' '{ print $2 }'
