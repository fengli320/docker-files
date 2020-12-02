FROM rust:1.47.0-buster

RUN groupadd fengli -g 1000
RUN useradd -u 1000 -g 1000 -s /bin/bash -d /data/repo/git/private-notebook/Linux fengli
RUN echo root:root | chpasswd

WORKDIR /root
COPY debian-container-init.sh debian-container-init.sh
RUN . ./debian-container-init.sh

ENTRYPOINT ["su", "-", "fengli"]
