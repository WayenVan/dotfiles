#!/usr/bin/env bash
#
# third-party.sh — third_party 依赖的初始化 / 更新统一入口
#
#   用法:
#     ./third-party.sh init    初始化所有 submodule (partial clone)
#                              并按 third_party.sparse 配置 sparse checkout
#     ./third-party.sh update  把所有 submodule 更新到远端最新,
#                              并重新应用 sparse 配置
#
# 依赖清单见 ./third_party.sparse, 每行一个仓库:
#   <submodule 路径> <要保留的目录/文件, 空格分隔>
#
# 新电脑上只需:
#   git clone <your-repo> && cd <your-repo> && ./third-party.sh init

set -euo pipefail

cd "$(dirname "$0")"

MANIFEST="third_party.sparse"

die() {
    echo "error: $*" >&2
    exit 1
}

[[ -f "$MANIFEST" ]] || die "manifest 文件 $MANIFEST 不存在"

apply_sparse() {
    while read -r repo paths; do
        [[ -z "${repo:-}" || "$repo" == \#* ]] && continue

        if [[ ! -d "$repo" ]]; then
            echo "skip: $repo 目录不存在" >&2
            continue
        fi

        if [[ -z "${paths:-}" ]]; then
            echo "skip: $repo 未指定 sparse 路径, 保留完整 checkout" >&2
            continue
        fi

        echo "configuring sparse checkout: $repo -> $paths"
        git -C "$repo" sparse-checkout init --cone
        # shellcheck disable=SC2086
        git -C "$repo" sparse-checkout set $paths
    done < "$MANIFEST"
}

case "${1:-}" in
    init)
        git submodule update --init --depth=1 --filter=blob:none
        apply_sparse
        ;;
    update)
        git submodule update --remote
        apply_sparse
        ;;
    *)
        die "用法: $0 {init|update}"
        ;;
esac
