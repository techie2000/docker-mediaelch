FROM base/archlinux:latest

RUN pacman -Syy && pacman -S git && git clone https://aur.archlinux.org/mediaelch.git && cd mediaelch && makepkg -si 
