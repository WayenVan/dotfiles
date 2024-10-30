FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-devel

WORKDIR /workspace

#setup compile flags, using multi-threading when compiling
ENV CFLAGS="-O3 -march=native -fopenmp"
ENV NVCCFLAGS="-Xcompiler -fopenmp -O3 -Xcompiler -march=native"
ENV MAKEFLAGS="-j$(nproc)"

# Run apt update at the very beginning
RUN apt-get update && \
  apt-get install -y wget curl git unzip build-essential ffmpeg libsm6 libxext6 git-lfs && \
  rm -rf /var/lib/apt/lists/*

#setup shells
SHELL ["/bin/bash", "-c"]
ENV SHELL="/bin/bash"

#install starship
RUN curl -sS https://starship.rs/install.sh | sh && \
  echo 'eval "\$(starship init bash)"' >> ~/.bashrc

# install general python packages
RUN pip install --no-cache-dir uv==0.4.25 && \
  # install unsloth and other python package
  uv pip install --no-cache-dir --system     \
  hydra-core==1.3.2                          \
  omegaconf==2.3.0                           \
  timm==1.0.9                                \
  tqdm==4.65.2                               \
  click==8.1.7                               \
  einops==0.8.0                              \
  lightning==2.3.3                           \
  lmdb==1.5.1                                \
  openmim==0.3.9                             \
  xformers==0.0.27                           \
  torchtext==0.18.0                          \
  matplotlib==3.9.2

# install mmseries would comppile so it will be a long time
RUN mim install --no-cache-dir mmengine==0.10.5 mmcv==2.1.0 && \
  mim install --no-cache-dir "mmdet==3.2.0" "mmpose==1.3.2" "mmpretrain==1.2.0"
# mim install --no-cache-dir "mmpose==1.3.2" 
# mmdet>=3.1.0 mmpose>=1.1.0 mmpretrain
#
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

# install nvim here
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
  rm -rf /opt/nvim && \
  tar -C /opt -xzf nvim-linux64.tar.gz && \
  rm nvim-linux64.tar.gz
ENV PATH="$PATH:/opt/nvim-linux64/bin"

# google download tool and neptune
RUN uv pip install --no-cache-dir gdown neptune --system

# finally put my personal dotfiles in the container
RUN git clone https://github.com/WayenVan/dotfiles.git && \
  cd dotfiles && git lfs pull && bash install


