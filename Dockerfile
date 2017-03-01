FROM base/archlinux:latest

RUN pacman -Syy --noconfirm
RUN pacman -S --noconfirm git
RUN git clone https://aur.archlinux.org/mediaelch.git 
RUN cd mediaelch && makepkg -si 
