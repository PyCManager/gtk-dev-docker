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
