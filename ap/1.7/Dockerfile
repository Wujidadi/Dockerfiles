FROM wujidadi/ap:1.6
LABEL MAINTAINER="wujidadi@gmail.com"

ARG nodeversion=18

# Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_${nodeversion}.x | sudo -E bash -;\
    apt-get install -y nodejs;\
    apt autoremove -y; apt clean

CMD [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND" ]
