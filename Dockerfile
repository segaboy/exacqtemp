#base image. Official supported 64-bit LTS from Canonical
FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

#Actually user Bash!
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

#Add support for 32-bit applications
RUN dpkg --add-architecture i386

#Update packages silents, answering yes to all prompts
RUN apt-get update -yq

#Install server dependencies
RUN apt-get install -yq bind9-host \
	gcc-4.8-base:i386 \
	gcc-4.9-base:i386 \
	genisoimage \
	geoip-database \
	ifenslave \
	ifenslave-2.6 \
	krb5-config \
	krb5-locales \
	krb5-user \
	libbind9-90 \
	libc6:i386 \
	libdaemon0:i386 \
	libdns100 \
	libedit2 \
	libexpat1:i386 \
	libgcc1:i386 \
	libgeoip1 \
	libgssapi-krb5-2 \
	libgssrpc4 \
	libio-socket-inet6-perl \
	libio-socket-ssl-perl \
	libisc95 libisccc90 \
	libisccfg90 \
	libk5crypto3 \
	libkadm5clnt-mit9 \
	libkadm5srv-mit9 \
	libkdb5-7 \
	libkeyutils1 \
	libkrb5-3 \
	libkrb5support0 \
	liblwres90 \
	libnet-libidn-perl \
	libnet-ssleay-perl \
	libnspr4 \
	libnss3 \
	libnss3-nssdb \
	libnss3-tools \
	libopts25 \
	libpython-stdlib \
	libpython2.7-minimal \
	libpython2.7-stdlib \
	libsocket6-perl \
	libssl0.9.8:i386 \
	libstdc++6:i386 \
	libxml2 \
	ntp \
	python \
	python-minimal \
	python2.7 \
	python2.7-minimal \
	sgml-base \
	wget \
	wodim \
	xml-core \
	zlib1g:i386

#Get exacqvisiondeps package from AWS bucket, and exacq server
RUN wget https://s3-us-west-2.amazonaws.com/exacqdocker/exacqVisionServer-deps.deb http://exacq.com/reseller/7.2/exacqVisionServer-7.2.1.85489.deb --user guest --password exacqvisionip

RUN dpkg -i exacqVisionServer-deps.deb
RUN dpkg -i exacqVisionServer-7.2.1.85489.deb

EXPOSE 22609

ENTRYPOINT "/usr/exacq/server/core"
