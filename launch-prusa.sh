
export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :1 &

xhost si:localuser:root
sudo docker run --rm -e DISPLAY=$DISPLAY -v ${TMPDIR}/.X11-unix:/tmp/.X11-unix:rw -it prusa
