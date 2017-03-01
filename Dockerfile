FROM base/archlinux:latest

RUN git clone https://aur.archlinux.org/mediaelch.git && cd mediaelch && makepkg -si 
