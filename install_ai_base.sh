# This script is designed to work with ubuntu 16.04 LTS

# ensure system is updated and has basic build tools
sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes install tmux build-essential gcc g++ make binutils
sudo apt-get --assume-yes install software-properties-common

# download and install GPU drivers
#wget "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.44-1_amd64.deb" -O "cuda-repo-ubuntu1604_8.0.44-1_amd64.deb"
wget "https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.168-1_amd64.deb" -O "cuda-repo-ubuntu1804_10.1.168-1_amd64.deb"


#sudo dpkg -i cuda-repo-ubuntu1604_8.0.44-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1804_10.1.168-1_amd64.deb
sudo apt-get update
sudo apt-get -y install cuda
sudo modprobe nvidia
nvidia-smi

# install Anaconda for current user
mkdir downloads
cd downloads
#wget "https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh" -O "Anaconda2-4.2.0-Linux-x86_64.sh"
#bash "Anaconda2-4.2.0-Linux-x86_64.sh" -b
wget "https://repo.continuum.io/archive/Anaconda3-2019.07-Linux-x86_64.sh" -O "Anaconda3-2019.07-Linux-x86_64.sh"
bash "Anaconda3-2019.07-Linux-x86_64.sh" -b




#echo "export PATH=\"$HOME/anaconda2/bin:\$PATH\"" >> ~/.bashrc
echo "export PATH=\"$HOME/anaconda3/bin:\$PATH\"" >> ~/.bashrc

#export PATH="$HOME/anaconda2/bin:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"

conda install -y bcolz
conda upgrade -y --all

# install and configure theano
pip install theano
echo "[global]
device = gpu
floatX = float32
[cuda]
root = /usr/local/cuda" > ~/.theanorc

# install and configure keras
pip install keras==1.2.2
mkdir ~/.keras
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}' > ~/.keras/keras.json

# install cudnn libraries
wget "http://files.fast.ai/files/cudnn.tgz" -O "cudnn.tgz"
#wget "https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.6.2.24/prod/10.1_20190719/cudnn-10.1-linux-x64-v7.6.2.24.tgz" -O "cudnn.tgz"
wget "/home/jai/Downloads/cudnn-10.1-linux-x64-v7.6.2.24.tgz" -O 'cudnn.tgz"


tar -zxf cudnn.tgz
cd cuda
sudo cp lib64/* /usr/local/cuda/lib64/
sudo cp include/* /usr/local/cuda/include/

# configure jupyter and prompt for password
jupyter notebook --generate-config
jupass=`python -c "from notebook.auth import passwd; print(passwd())"`
echo "c.NotebookApp.password = u'"$jupass"'" >> $HOME/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py



# clone the fast.ai course repo and prompt to start notebook
cd ~
git clone https://github.com/fastai/courses.git
echo "\"jupyter notebook\" will start Jupyter on port 8888"
echo "If you get an error instead, try restarting your session so your $PATH is updated"

#https://hub.docker.com/r/tensorflow/tensorflow/
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

# pub   rsa4096 2017-02-22 [SCEA]
#      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
# uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
# sub   rsa4096 2017-02-22 [S]

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
apt-cache madison docker-ce
# docker-ce | 5:18.09.1~3-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages
# docker-ce | 5:18.09.0~3-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages
# docker-ce | 18.06.1~ce~3-0~ubuntu       | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages
#  docker-ce | 18.06.0~ce~3-0~ubuntu       | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages
#  ...

sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io

sudo docker run hello-world

# If you would like to use Docker as a non-root user, 
# you should now consider adding your user to the “docker” group with something like:

sudo usermod -a -G docker $USER

docker run -it --rm -v $(realpath ~/notebooks):/tf/notebooks -p 8888:8888 tensorflow/tensorflow:latest-py3-jupyter



# Install tensorflow datasets
pip install -q tensorflow-datasets



#useful links
# https://ml-cheatsheet.readthedocs.io/en/latest/loss_functions.html
# https://github.com/fastai/courses/blob/master/setup/install-gpu.sh
# http://wiki.fast.ai/index.php/Ubuntu_installation

# https://repo.continuum.io/archive/
# https://www.osetc.com/en/how-to-install-nvidia-cudnn-on-ubuntu-16-04-18-04-linux.html
# https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html
# https://developer.nvidia.com/rdp/cudnn-download
