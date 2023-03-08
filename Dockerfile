FROM debian:bullseye

RUN apt-get update && apt-get install -y \
  freeglut3 \
  libgtk2.0-dev \
  libwxgtk3.0-gtk3-dev \
  libwx-perl \
  libxmu-dev \
  libgl1-mesa-glx \
  libgl1-mesa-dri \
  xdg-utils \
  locales \
  wget \
  ca-certificates \
  bash \
  dbus-x11 \
  bzip2 \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -y \
  && apt-get autoclean

# Install xfce4-session with all recommended packages
RUN apt-get update && apt-get install -y \
  xfce4-session  \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -y \
  && apt-get autoclean

RUN sed -i \
	-e 's/^# \(cs_CZ\.UTF-8.*\)/\1/' \
	-e 's/^# \(de_DE\.UTF-8.*\)/\1/' \
	-e 's/^# \(en_US\.UTF-8.*\)/\1/' \
	-e 's/^# \(es_ES\.UTF-8.*\)/\1/' \
	-e 's/^# \(fr_FR\.UTF-8.*\)/\1/' \
	-e 's/^# \(it_IT\.UTF-8.*\)/\1/' \
	-e 's/^# \(ko_KR\.UTF-8.*\)/\1/' \
	-e 's/^# \(pl_PL\.UTF-8.*\)/\1/' \
	-e 's/^# \(uk_UA\.UTF-8.*\)/\1/' \
	-e 's/^# \(zh_CN\.UTF-8.*\)/\1/' \
	/etc/locale.gen \
  && locale-gen

RUN groupadd slic3r \
  && useradd -g slic3r --create-home --home-dir /home/slic3r slic3r \
  && mkdir -p /Slic3r \
  && chown slic3r:slic3r /Slic3r

WORKDIR /Slic3r
RUN wget --no-check-certificate https://github.com/prusa3d/PrusaSlicer/releases/download/version_2.5.0/PrusaSlicer-2.5.0+linux-aarch64-GTK3-202209071828.tar.bz2

# Settings storage
RUN mkdir -p /home/slic3r/.local/share/

RUN tar -xf PrusaSlicer-2.5.0+linux-aarch64-GTK3-202209071828.tar.bz2 --directory /Slic3r/

VOLUME /home/slic3r/

COPY entry.sh /usr/local/bin/entry.sh
RUN chmod 777 /usr/local/bin/entry.sh

#ENTRYPOINT [ "bash /home/slic3r/entry.sh" ]
CMD /usr/local/bin/entry.sh
