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




#useful links
# https://ml-cheatsheet.readthedocs.io/en/latest/loss_functions.html
# https://github.com/fastai/courses/blob/master/setup/install-gpu.sh
# http://wiki.fast.ai/index.php/Ubuntu_installation

# https://repo.continuum.io/archive/
# https://www.osetc.com/en/how-to-install-nvidia-cudnn-on-ubuntu-16-04-18-04-linux.html
# https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html
# https://developer.nvidia.com/rdp/cudnn-download
