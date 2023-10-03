#!/usr/bin/env bash
echo "$0 started" >> /tmp/session.log
session=/org/freedesktop/login1/session/$XDG_SESSION_ID
iface=org.freedesktop.login1.Manager
dbus-monitor --system "type=signal,path=$session,interface=$iface" 2>/dev/null |
 while read signal stamp sender arrow dest rest; do
  case "$rest" in
    *Lock)
      echo   LOCKED at $stamp >> /tmp/session.log
;;
    *Unlock)
      echo UNLOCKED at $stamp >> /tmp/session.log
;;  #unknown Session signal received
    *)
      echo $signal $stamp $sender $arrow $dest $rest >> /tmp/session.log
  esac
done

