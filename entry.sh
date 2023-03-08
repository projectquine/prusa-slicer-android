#!/bin/bash
export DISPLAY=:1
# Start desktop session
xfce4-session &
sleep 5
# start prusa slicer
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
/Slic3r/PrusaSlicer-2.5.0+linux-aarch64-GTK3-202209071828/prusa-slicer 

