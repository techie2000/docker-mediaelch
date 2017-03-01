FROM base/archlinux:latest

RUN pacman -Sqyu --noconfirm --needed openssh sed && \
    systemctl enable sshd

# configure ssh
RUN sed -i \
        -e 's/^#*\(PermitRootLogin\) .*/\1 yes/' \
        -e 's/^#*\(PasswordAuthentication\) .*/\1 yes/' \
        -e 's/^#*\(PermitEmptyPasswords\) .*/\1 yes/' \
        -e 's/^#*\(UsePAM\) .*/\1 no/' \
        /etc/ssh/sshd_config

# install base packages
RUN pacman -Sqyu --noconfirm --needed openssh  && \
    systemctl enable sshd
RUN pacman -Sqyu --needed git sudo wget grep base-devel gzip --noconfirm
RUN rm /var/cache/pacman/pkg/*


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

EXPOSE 22
CMD ["/usr/bin/init"]
