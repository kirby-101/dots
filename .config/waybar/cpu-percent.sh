#!/usr/bin/env bash
vmstat 1 2 | tail -1 | awk '{print 100-$19"%"}'
