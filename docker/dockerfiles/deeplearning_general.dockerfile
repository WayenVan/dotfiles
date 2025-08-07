FROM pytorch/pytorch:2.4.0-cuda11.8-cudnn9-devel

WORKDIR /workspace

#setup compile flags, using multi-threading when compiling
ENV CFLAGS="-O3 -march=native -fopenmp"
ENV NVCCFLAGS="-Xcompiler -fopenmp -O3 -Xcompiler -march=native"
ENV MAKEFLAGS="-j$(nproc)"

# Run apt update at the very beginning
RUN apt-get update && \
  apt-get install -y wget curl git unzip build-essential ffmpeg libsm6 libxext6 git-lfs openssh-client openssh-server && \
  rm -rf /var/lib/apt/lists/*

#setup shells
SHELL ["/bin/bash", "-c"]
ENV SHELL="/bin/bash"

#install starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
  echo 'eval "$(starship init bash)"' >> ~/.bashrc

# install general python packages
# WARN: uv behaviour is different from pip, expecially in rocm build, may influence the package dependency
RUN pip install --no-cache-dir uv && \
  # install unsloth and other python package
  uv pip install --no-cache-dir --system        \
  hydra-core                                    \
  omegaconf                                     \
  tqdm                                          \
  click                                         \
  einops                                        \
  lightning                                     \
  lmdb                                          \
  matplotlib                                    \
  polars                                        \
  accelerate                                    \
  albumentations                                \
  timm                                          \
  opencv-python-headless                        \
  accelerate                                    \
  transformers                                \
  datasets                                \
  trl                                \
  peft                                \
  tensordict \
  nlpaug \
  pandas \
  geoloss \
  diskcache\
  numpy==1.26.4 
# NOTE: downgrading numpy to 1.26.4, because of the issue with mmcv

#install mmlab using my own cloned repo
RUN git clone --recursive https://github.com/WayenVan/sapiens.git && \
  cd sapiens && git lfs pull && \
  bash ./my_install.sh
#
# install ctcdecoder
RUN git clone --recursive https://github.com/WayenVan/ctcdecode.git && \
  cd ctcdecode && uv pip install --no-cache-dir --system --no-build-isolation . && \
  cd .. && rm -rf /workspace/ctcdecode

# install sclit
RUN git clone --recursive https://github.com/usnistgov/SCTK.git && \
  cd SCTK &&  \
  make config && \
  make all && \
  make install && \
  make doc
ENV PATH="/workspace/SCTK/bin:${PATH}"
ENV PATH="/root/.npm/bin:${PATH}"


# install x command and its tools
RUN eval "$(curl https://get.x-cmd.com)" && \
  x env use fzf yazi eza node fd zellij zoxide
ENV PATH="/root/.x-cmd.root/local/data/pkg/sphere/X/l/j/h/bin:/root/.x-cmd.root/bin:${PATH}"
# alias for command line tools
RUN echo "alias fzf='fzf'" >> ~/.bashrc && \
  echo "alias ls='eza'" >> ~/.bashrc && \
  echo "alias ll='eza -al'" >> ~/.bashrc && \
  echo "eval \$(zoxide init bash)" >> ~/.bashrc
# add source file
RUN echo "source ~/.bashrc" >> ~/.bash_profile

# install release
# RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
#   rm -rf /opt/nvim && \
#   tar -C /opt -xzf nvim-linux64.tar.gz && \
#   rm nvim-linux64.tar.gz
# ENV PATH="$PATH:/opt/nvim-linux64/bin"
# install nightly
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
  rm -rf /opt/nvim && \
  tar -C /opt -xzf nvim-linux-x86_64.tar.gz && \
  rm nvim-linux-x86_64.tar.gz
ENV PATH="$PATH:/opt/nvim-linux-x86_64/bin"

#install web tool file browser and ngrok
RUN curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
  | tee /etc/apt/sources.list.d/ngrok.list \
  && apt update \
  && apt install ngrok \
  && rm -rf /var/lib/apt/lists/*
# RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
RUN wget -P filebrowser https://github.com/gtsteffaniak/filebrowser/releases/download/v0.7.18-beta/linux-amd64-filebrowser && \
  chmod +x filebrowser/linux-amd64-filebrowser && \
  mv filebrowser/linux-amd64-filebrowser filebrowser/filebrowser
ENV PATH="/workspace/filebrowser:${PATH}"

# install other thins with pip
RUN  pip install --no-cache-dir gdown wandb

# install ssh server
RUN mkdir -p /var/run/sshd \
  && chmod 0755 /var/run/sshd

RUN echo "root:root" | chpasswd \
  && sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
# && sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# finally put my personal dotfiles in the container
RUN git clone https://github.com/WayenVan/dotfiles.git && \
  cd dotfiles && git lfs pull && bash install

# git setup
RUN git config --global credential.helper store
RUN git config --global pull.rebase true

ENV CONDA_PREFIX=/opt/conda

