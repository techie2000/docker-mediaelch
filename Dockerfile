FROM base/archlinux:latest

RUN pacman -Syy
RUN pacman -S git
RUN git clone https://aur.archlinux.org/mediaelch.git 
RUN cd mediaelch && makepkg -si 
