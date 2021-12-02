#!/bin/bash

ping -c 2 -W 2 -q 192.168.68.105 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
  echo "0"
  exit 0
fi

COUNT=$(ssh -o "StrictHostKeyChecking no" treydock@192.168.68.105 "ss | grep -v '192.168.68.127' | grep -c ssh")
if [ $COUNT -gt 0 ]; then
  echo $COUNT
  exit 0
fi

echo "0"
exit 0

