# Linux / macOS 白霜 OpenCC 加载优化

将白霜的 Emoji、拆字、中英互译、火星文文本词典编译为 `.ocd2`。
保留上游 `.txt` 和 `.json`，生成的 `dotfiles-*` 文件仅存放在本机 Rime
的 `opencc/` 目录，不提交到 dotfiles。脚本自动选择 Linux 的
`~/.config/ibus/rime` 或 macOS 鼠须管的 `~/Library/Rime`。
也可用 `--rime-dir` 指定其他目录。

在仓库根目录执行。Linux（Fedora）首次设置：

```sh
sudo dnf install opencc-tools
/usr/bin/python3 rime/compile-opencc.py
./cm apply ~/.config/ibus/rime/rime_frost.custom.yaml
```

macOS 首次设置（需要已安装 Homebrew、鼠须管和白霜）：

```sh
brew install opencc python
python3 rime/compile-opencc.py
./cm apply ~/Library/Rime/rime_frost.custom.yaml
```

请使用与 Homebrew OpenCC 架构一致的 Python（避免混用 Rosetta 和原生
Apple Silicon 环境）。脚本会从 `opencc_dict` 的实际安装位置查找动态库。
macOS 适配已做模拟检查，尚未在真实 Mac 上验证；鼠须管内置的 OpenCC
还需能读取本机工具生成的 `.ocd2`。

日常 `apply` 不会自动编译。更新白霜后重新运行编译脚本，再从 Rime
菜单重新部署即可；独立 JSON 名称不变，一般不必再次 `apply`。

随后从 Rime 菜单选择「重新部署」。脚本先编译所有词典，再用系统 OpenCC
逐条比较文本版与二进制版的转换输出，通过后才发布独立配置（不等同于
验证 Rime 的全部多候选行为）。这避免了 OpenCC 1.1.9 导出文本的已知
崩溃问题（上游 issue #923）。两端模板都只在各自目录的全部
独立配置存在时启用优化，否则使用原配置。

如需回退，先把 `opencc/dotfiles-*.json` 移到备份目录，再执行上述
`cm apply` 并重新部署。无需删除原始词典或用户词库。

重新部署使用 Rime 菜单。不要用 `IBus.InputContext.new()` 包装 GNOME
正在使用的输入上下文：该代理默认拥有远端对象，释放时会销毁它，导致
GNOME 持续报 `InputContext ... does not exist`，输入法无法接收按键。

本机验证（2026-09-28）：7 份词典共 188893 个键的转换输出一致；
优化的 5 项 OpenCC 配置加载时间合计约 364 → 74 毫秒。
重新启动后的 Rime 日志确认加载 `dotfiles-*.json`，后续 3 次引擎
初始化约 117–124 毫秒（优化前约 430 毫秒）。此数值不包含 GNOME
快捷键处理及应用接收输入事件的时间。
