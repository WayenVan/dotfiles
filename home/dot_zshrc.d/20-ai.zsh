# Shared entry point for AI-related Zsh commands and widgets.

ai() {
  local prompt

  prompt=$(gum input --prompt "AI> " --placeholder "Ask a question...") || return
  [[ -n "$prompt" ]] || return

  command opencode run \
    --agent plan \
    --model deepseek/deepseek-flash \
    "请简短回答：$prompt" | command glow -
}
