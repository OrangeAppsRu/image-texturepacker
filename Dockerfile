FROM ubuntu:20.04@sha256:3093096ee188f8ff4531949b8f6115af4747ec1c58858c091c8cb4579c39cc4e
LABEL org.opencontainers.image.source https://github.com/OrangeAppsRu/image-texturepacker

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends libgl1-mesa-glx libglib2.0-0 curl git ca-certificates openjdk-8-jre locales \
    && sed -i '/en_US.UTF-8/s/^# //g;' /etc/locale.gen \
    && printf "en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen \
    && printf "LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8\n" > /etc/default/locale \
    && curl -o TexturePacker-5.5.0-ubuntu64.deb -L https://www.codeandweb.com/download/texturepacker/5.5.0/TexturePacker-5.5.0-ubuntu64.deb \
    && echo '9d6408d581b11963fac081a2b1b02486 TexturePacker-5.5.0-ubuntu64.deb' | md5sum -c \
    && dpkg -i TexturePacker-5.5.0-ubuntu64.deb \
    && rm -f TexturePacker-5.5.0-ubuntu64.deb \
    && curl -o swarm-client-3.24.jar -L https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.24/swarm-client-3.24.jar \
    && echo '0b8d2e5f4f858fc7f6267ca579345abf swarm-client-3.24.jar' |md5sum -c \
    && mv swarm-client-*.jar /usr/local/bin/swarm-client.jar \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && apt-get install -y --no-install-recommends nodejs \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*
COPY ./entrypoint.sh /entrypoint.sh
ENV JENKINS_URL=https://127.0.0.1
ENV EXECUTORS=1
ENV TOKEN=token
ENV USERNAME=user
ENV MODE=exclusive
ENV LABELS=default_label
ENV NAME=default_agent
ENV FSROOT=/root/
ENTRYPOINT ["/entrypoint.sh"]
