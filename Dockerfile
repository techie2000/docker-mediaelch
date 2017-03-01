FROM base/archlinux:latest

# install base packages
RUN pacman -Syu --noconfirm
RUN pacman -S --needed git --noconfirm

# add user, because packaging is not allowed as root
RUN useradd makepkg ; echo "makepkg ALL = (root) NOPASSWD:ALL" >> /etc/sudoers.d/makepkg

# create temp directory and run git checkouts
RUN mkdir /tmp/install
WORKDIR /tmp/install

# install MediaElch
RUN git clone https://aur.archlinux.org/mediaelch.git 
RUN chown makepkg -R /tmp/install
WORKDIR /tmp/install/mediaelch/
RUN su -c "makepkg -si --noconfirm" -s /bin/bash makepkg

# Clean tmp
RUN rm -dR /tmp/install
