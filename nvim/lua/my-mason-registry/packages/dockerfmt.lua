local Pkg = require("mason-core.package")
local platform = require("mason-core.platform")

return Pkg.new({
  name = "dockerfmt",
  desc = [[A simple Dockerfile formatter that follows best practices and enforces a consistent style.]],
  homepage = "https://github.com/reteps/dockerfmt",
  categories = { Pkg.Cat.Formatter },
  languages = { Pkg.Lang.docker },

  install = function(ctx)
    if platform.is.darwin or platform.is.win then
      error("dockerfmt is not available for macOS or Windows.")
    end

    local asset = "dockerfmt-v0.3.7-linux-amd64.tar.gz"
    local url = ("https://github.com/reteps/dockerfmt/releases/download/v0.3.7/%s"):format(asset)

    -- 下载到当前目录
    ctx.spawn.curl({ "-fL", url, "-o", asset })
    ctx.spawn.tar({ "-xzf", asset })
    ctx:link_bin("dockerfmt", "dockerfmt")

    -- -- 解压（zip 或 tar.gz）
    -- if asset:match("%.zip$") then
    --   ctx.spawn.unpack({ asset }) -- 如果系统没有 unpack 命令，可替换成 `ctx.spawn.unzip { ... }`
    -- else
    --   -- 使用 tar 提取并去掉顶层目录（视包结构调整）
    -- end

    -- 标记来源（archive/http）
    ctx.receipt:with_primary_source({
      type = "github_release_file",
      url = url,
    })
  end,
})
