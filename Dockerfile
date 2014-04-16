# VERSION 0.1
# DOCKER-VERSION  0.9.1
# AUTHOR:         Irene Knapp <irene.knapp@icloud.com>
# DESCRIPTION:    Image with Hubot chat automaton, built from source.
# TO_BUILD:       docker build -rm -t hubot .
# TO_RUN:         docker run -v /media/state/hubot:/media/host hubot
#
#   To initialize your config and state files, do:
#
#     docker run -v /media/state/hubot:/media/host hubot /usr/local/bin/hubot \
#       --create /media/host

FROM debian-stable

RUN echo deb http://security.debian.org/ wheezy/updates main \
      >> /etc/apt/sources.list; \
    echo deb http://http.us.debian.org/debian unstable main \
      >> /etc/apt/sources.list; \
    echo "Package: *" > /etc/apt/preferences.d/hybrid; \
    echo "Pin: release a=stable" >> /etc/apt/preferences.d/hybrid; \
    echo "Pin-Priority: 800" >> /etc/apt/preferences.d/hybrid; \
    echo "" >> /etc/apt/preferences.d/hybrid; \
    echo "Package: *" >> /etc/apt/preferences.d/hybrid; \
    echo "Pin: release a=unstable" >> /etc/apt/preferences.d/hybrid; \
    echo "Pin-Priority: 600" >> /etc/apt/preferences.d/hybrid; \
    DEBIAN_FRONTEND=noninteractive apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -t unstable \
      nodejs npm; \
    ln -s /usr/bin/nodejs /usr/local/bin/node; \
    npm install -g hubot coffee-script; \
    rm /var/lib/apt/lists/*_*
CMD /media/host/bin/hubot
