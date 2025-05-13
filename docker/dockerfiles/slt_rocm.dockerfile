FROM rocm/pytorch:rocm6.4_ubuntu24.04_py3.12_pytorch_release_2.3.0

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
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
  echo 'eval "$(starship init bash)"' >> ~/.bashrc

# install general python packages
RUN pip install --no-cache-dir uv && \
  # install unsloth and other python package
  uv pip install --no-cache-dir --system     \
  hydra-core                                 \
  omegaconf                                  \
  timm                                       \
  tqdm                                       \
  click                                      \
  einops                                     \
  lightning                                  \
  lmdb                                       \
  xformers                                   \
  matplotlib                                 \
  piloars                                    \
  transformers                               

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

# google download tool and neptune
RUN uv pip install --no-cache-dir gdown neptune wandb --system

# finally put my personal dotfiles in the container
RUN git clone https://github.com/WayenVan/dotfiles.git && \
  cd dotfiles && git lfs pull && bash install


