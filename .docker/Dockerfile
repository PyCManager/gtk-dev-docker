FROM python:slim-bullseye

ENV RUNNING_IN_CONTAINER=1

RUN useradd -s /bin/bash -m vscode
RUN groupadd docker && usermod -aG docker vscode

USER vscode

ENTRYPOINT ["sleep", "infinity"]
