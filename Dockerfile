FROM       ubuntu:16.04

# Add MediaElch Repo
RUN echo deb http://ppa.launchpad.net/kvibes/mediaelch/ubuntu xenial main >> /etc/apt/sources.list.d/mediaelch.list
RUN echo deb-src http://ppa.launchpad.net/kvibes/mediaelch/ubuntu xenial main >> /etc/apt/sources.list.d/mediaelch.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 00DAEE81 && apt-get update

# Install MediaElch
RUN apt-get install -y mediaelch

# Install SSH server
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Configuration SSH
RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# Create user
RUN adduser --disabled-password --gecos ""  mediaelch

EXPOSE 22

COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD    ["/usr/sbin/sshd", "-D"]
