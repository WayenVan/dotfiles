local a = vim.system({ [[:!powershell -Command "Get-Command python | Select-Object -ExpandProperty Definition"]] })
vim.notify(a)
