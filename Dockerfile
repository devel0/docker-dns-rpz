FROM searchathing/ubuntu

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

#--[ tmp resolv.conf ]
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

#====================================================================
# install
#====================================================================

#--[ dns ]
RUN apt-get install -y bind9

RUN apt-get install -y openssh-server

#====================================================================
# configure
#====================================================================

#--[ dns ]
COPY imgdata/named.conf.local /etc/bind
COPY imgdata/named.conf.options /etc/bind
RUN chmod 640 /etc/bind/named.conf.local
RUN chgrp bind /etc/bind/named.conf.local

COPY imgdata/db.rpz /etc/bind

#====================================================================

COPY ./imgdata/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash", "--login"]
