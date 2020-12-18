FROM jlesage/baseimage-gui:ubuntu-18.04-v3

RUN apt-get update -y
RUN apt-get upgrade -y

# Required for `add-apt-repository`
RUN apt-get install -y software-properties-common

# Add the repository to your system
RUN add-apt-repository ppa:mediaelch/mediaelch-stable
RUN apt-get update -y
# Install MediaElch
RUN apt-get install -y mediaelch

# MediaElch requires a more modern GCC:
#RUN add-apt-repository ppa:ubuntu-toolchain-r/test
#RUN apt-get update -y
#RUN apt-get install -y g++-8 gcc-8
#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 90
#RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 90

# Build tools and other libraries
#RUN apt-get install -y build-essential git libcurl4-openssl-dev
#RUN apt-get install -y libmediainfo-dev
# ffmpeg is required at runtime to create random screenshots
RUN apt-get install -y ffmpeg

# Qt (alternative: download and install Qt from its official website)
#RUN apt-get install -y qt5-default qtmultimedia5-dev qtdeclarative5-dev qtdeclarative5-controls-plugin qtdeclarative5-models-plugin

# Get and Build
#RUN git clone https://github.com/Komet/MediaElch.git
#RUN cd MediaElch
#RUN git submodule update --init
#RUN mkdir build && cd $_
#RUN qmake ..
#RUN make -j4

# Install
#RUN make install

# Install SSH server
#RUN apt-get install -y openssh-server
#RUN mkdir /var/run/sshd

# Create user
RUN adduser --disabled-password --gecos ""  mediaelch

# Configuration SSH
#RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config
#RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

#RUN mkdir -p /home/mediaelch/.ssh && chown mediaelch:mediaelch /home/mediaelch/.ssh && chmod 700 /home/mediaelch/.ssh

# Entrypoint
COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8  
RUN update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
RUN echo 'export LC_ALL=en_US.UTF-8' >> /home/mediaelch/.profile
RUN echo 'export LANG=en_US.UTF-8' >> /home/mediaelch/.profile
RUN echo 'export LANGUAGE=en_US.UTF-8' >> /home/mediaelch/.profile
RUN echo 'export LC_ALL=en_US.UTF-8' >> /home/mediaelch/.bashrc
RUN echo 'export LANG=en_US.UTF-8' >> /home/mediaelch/.bashrc
RUN echo 'export LANGUAGE=en_US.UTF-8' >> /home/mediaelch/.bashrc

#EXPOSE 22
#VOLUME /movies /shows /home/mediaelch/.config/kvibes /home/mediaelch/.ssh/authorized_keys
# Define mountable directories.
ENV APP_NAME="MediaElch"
VOLUME ["/movies"]
VOLUME ["/home/mediaelch/.config/kvibes"]

COPY startapp.sh /startapp.sh

#ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
#CMD    ["/usr/sbin/sshd", "-D"]
