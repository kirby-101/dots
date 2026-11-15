#!/usr/bin/env bash

route -n show default | awk '
/interface:/ { iface=$2 }
/gateway:/   { gw=$2 }
END { print iface ":" gw }'
