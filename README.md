# 💤 Based on the LazyVim

My template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Third-party dependencies (third_party/)

third_party/ 下的第三方仓库由 `third_party.sparse`(清单)+ `third-party.sh`(通用脚本)管理。

新电脑一条命令恢复:

    git clone <your-repo> && cd <your-repo> && ./third-party.sh init

新增第三方仓库(三步):

    git submodule add <url> third_party/<name>
    echo "third_party/<name> <paths>" >> third_party.sparse
    git add .gitmodules third_party third_party.sparse && git commit

更新所有第三方仓库:

    ./third-party.sh update


