FROM rockylinux/rockylinux:8.10

WORKDIR /workspace

#setup compile flags, using multi-threading when compiling
ENV CFLAGS="-O3 -march=native -fopenmp"
ENV NVCCFLAGS="-Xcompiler -fopenmp -O3 -Xcompiler -march=native"
ENV MAKEFLAGS="-j$(nproc)"

RUN dnf -y update && \
  dnf -y groupinstall "Development Tools" && \
  dnf -y install \
  git \
  curl \
  wget \
  make \
  gcc \
  gcc-c++ \
  clang \
  llvm \
  tar \
  gzip \
  xz \
  unzip \
  which \
  musl-gcc \
  musl-devel \
  musl-libc-static \
  ca-certificates && \
  dnf clean all

#setup shells
SHELL ["/bin/bash", "-c"]
ENV SHELL="/bin/bash"

#install starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
  echo 'eval "$(starship init bash)"' >> ~/.bashrc

# install x command and its tools
RUN eval "$(curl https://get.x-cmd.com)" && \
  x env use fzf yazi eza node fd zellij zoxide rg
ENV PATH="/root/.x-cmd.root/local/data/pkg/sphere/X/l/j/h/bin:/root/.x-cmd.root/bin:${PATH}"


# install cargo
# 安装 Rust/Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
  | sh -s -- -y --profile minimal

# 将 cargo 加入 PATH
ENV PATH="/root/.cargo/bin:${PATH}"
