#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "---" | tee -a /tmp/bar-top.log /tmp/bar-bottom.log
polybar top    >>/tmp/bar-top.log 2>&1 &
polybar bottom >>/tmp/bar-bottom.log 2>&1 &
ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-bottom