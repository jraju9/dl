# install google chrome

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install google-chrome-stable



# install sublime3 for current user


wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text


# install midi file processor timidity
sudo apt-get install timidity timidity-interfaces-extra


# install git
sudo apt install git

# install texlive to convert tex to pdf
sudo apt-get install texlive



# install virtenv
sudo apt install virtualenv


# change sound default
sudo apt-get install pavucontrol

#To open pavucontrol from the Terminal:
pavucontrol


#To install ffmpeg - required for animation or video conversion
sudo apt update
sudo apt install ffmpeg

#To validate that the package is installed properly use the ffmpeg -version command which prints the FFmpeg version:
fmpeg -version

#jai@ai-hub:~$ ffmpeg -version
#ffmpeg version 3.4.6-0ubuntu0.18.04.1 Copyright (c) 2000-2019 the FFmpeg developers
#built with gcc 7 (Ubuntu 7.3.0-16ubuntu3) configuration: --prefix=/usr --extra-version=0ubuntu0.18.04.1 --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu

#To print all available FFmpeg’s encoders and decoders type:

ffmpeg -encoders
ffmpeg -decoders

# Install python package
conda install -c conda-forge ffmpeg
