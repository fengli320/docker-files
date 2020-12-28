FROM golang:1.15.6-buster

RUN groupadd fengli -g 1000
RUN useradd -u 1000 -g 1000 -s /bin/bash -d /data/repo/git/private-notebook/Linux fengli
RUN echo root:root | chpasswd

WORKDIR /root
COPY golang-container-init.sh golang-container-init.sh
RUN . ./golang-container-init.sh

ENTRYPOINT ["su", "-", "fengli"]
