#!/bin/bash

ping -c 2 -W 2 192.168.68.105 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
  echo "0"
  exit 0
fi

STATUS=$(ssh -o "StrictHostKeyChecking no" treydock@192.168.68.105 /home/treydock/bin/desktop-active.sh)
if [ "$STATUS" = "1" ]; then
  echo "1"
  exit 0
fi

echo "0"
exit 0
