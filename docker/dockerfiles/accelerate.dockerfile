FROM huggingface/accelerate:gpu-deepspeed-nightly-2025-06-27

WORKDIR /workspace

#setup compile flags, using multi-threading when compiling
ENV CFLAGS="-O3 -march=native -fopenmp"
ENV NVCCFLAGS="-Xcompiler -fopenmp -O3 -Xcompiler -march=native"
ENV MAKEFLAGS="-j$(nproc)"

# Run apt update at the very beginning
RUN apt-get update && \
  apt-get install -y wget curl git unzip build-essential ffmpeg libsm6 libxext6 git-lfs openssh-client && \
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
  pandas 



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

# install other thins with pip
RUN  pip install --no-cache-dir gdown wandb

# finally put my personal dotfiles in the container
RUN git clone https://github.com/WayenVan/dotfiles.git && \
  cd dotfiles && git lfs pull && bash install


