############################################################
# Dockerfile to run Docker GTK
# Based on Alpine
############################################################
FROM python:alpine
MAINTAINER Patrick LUZOLO (eldorplus)

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1
ENV LANG=C.UTF-8
ENV RUNNING_IN_CONTAINER=1

#Packages System
RUN set -ex && \
    apk update && \
    apk add --no-cache --update-cache xauth xhost wget musl libpng libpng-dev meson libdazzle libdazzle-dev \
    unzip ffmpeg pkgconf pkgconfig ca-certificates-bundle grep py3-urlgrabber sudo \
    py3-ipaddr py3-requests py3-urllib3 py3-chardet py3-certifi py3-idna dconf intltool

#Libraries System
RUN set -ex && \
    apk update && \
    apk add --no-cache --update-cache libpng libpng-dev libjpeg libjpeg-turbo-dev libdc1394 libdc1394-dev \
    gst-plugins-base-dev v4l-utils-libs libtbb libtbb-dev libgphoto2 libgphoto2-dev v4l-utils-dev gettext-dev


#Packages and Libraries GTK
RUN set -ex && \
    apk update && \
    apk add --no-cache --update-cache gtk+3.0 py3-libvirt libvirt-glib libosinfo \
    gtk+2.0 glib-dev gtk+3.0-dev gst-plugins-base py3-gobject3 py3-cairo vte3 spice-gtk gtk-vnc \
    ttf-dejavu adwaita-icon-theme py3-docutils py3-setuptools gtksourceview4

#dbus-launch, dbus-run-session
RUN set -ex && \
    apk add --no-cache --update-cache dbus dbus-x11 libx11 libxcb libxdmcp \
    libxcb libx11 py3-dbus py3-dbus-dev dbus-dev

#libgnome-keyring
RUN set -ex && \
    apk add --no-cache --update-cache dbus-libs gnome-keyring \
    linux-pam gcr-base p11-kit glib pcre libmount libblkid libintl libcap-ng

#Git
RUN set -ex && \
   apk add --no-cache --update-cache git expat pcre2 && \
   #git config --global credential.helper store
   #git config --global credential.helper cache
   #see https://git-scm.com/docs/git-credential-cache
   git config --global credential.helper 'cache --timeout=3600'

#ssl, curl
#for curl-dev see https://stackoverflow.com/a/51849028/1137529
#for libffi-dev see https://stackoverflow.com/a/58396708/1137529
#for cargo see https://github.com/pyca/cryptography/issues/5776#issuecomment-775158562
RUN set -ex && \
    apk add --no-cache --update-cache openssl-dev musl-dev cyrus-sasl-dev \
    linux-headers unixodbc-dev curl-dev libffi-dev cargo

#https://stackoverflow.com/questions/5178416/libxml-install-error-using-pip
RUN set -ex && \
    apk add --no-cache --update-cache libxml2 libxml2-dev libxslt-dev py3-libxml2

#gcc, gfortran, lapack, blas (requires ssl layer above)
#see https://stackoverflow.com/questions/11912878/gcc-error-gcc-error-trying-to-exec-cc1-execvp-no-such-file-or-directory
#see https://stackoverflow.com/a/38571314/1137529
#see https://unix.stackexchange.com/questions/550290/using-blas-in-alpine-linux
RUN set -ex && \
    apk add --no-cache --update-cache cmake make gcc build-base lapack-dev freetype-dev gfortran openblas-dev

#https://github.com/h5py/h5py/issues/1461#issuecomment-562871041
#https://stackoverflow.com/questions/66705108/how-to-install-hdf5-on-docker-image-with-linux-alpine-3-13
RUN set -ex && \
    apk add --no-cache --update-cache hdf5-dev openssh-client

#bash+usefull utils
#curl is installed above
RUN set -ex && \
    apk add --no-cache --update-cache bash xterm nano mlocate curl && \
    updatedb && \
    #disable coloring for nano, see https://stackoverflow.com/a/55597765/1137529
    echo "syntax \"disabled\" \".\"" > ~/.nanorc; echo "color green \"^$\"" >> ~/.nanorc \
    && apk add openssh-askpass --repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
    && apk add py3-configparser --repository http://dl-3.alpinelinux.org/alpine/v3.10/community/ \
    && apk add ksshaskpass py3-argcomplete --repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
    && rm -rf /var/cache/apk/* /tmp/* /tmp/.[!.]* \
    && mkdir -p /usr/lib/ssh \
    && ln -s /usr/bin/ksshaskpass /usr/lib/ssh/ssh-askpass

RUN mkdir -p /home/vscode
RUN mkdir -p /etc/sudoers.d

# Now a few hacky things to share an X11 socket with the host.
# TODO: Use actual user/group ID instead of 1000
# Replace 'bash' with your favorite shell
RUN export uid=1000 gid=1000 && \
    echo "vscode:x:${uid}:${gid}:Developer,,,:/home/vscode:/bin/bash" >> /etc/passwd && \
    echo "vscode:x:${uid}:" >> /etc/group && \
    echo "vscode ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    chown ${uid}:${gid} -R /home/vscode

USER vscode
ENV HOME /home/vscode

ENTRYPOINT ["sleep", "infinity"]
