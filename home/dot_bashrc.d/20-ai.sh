# Shared entry point for AI-related Bash commands and bindings.

ai() {
  local prompt

  prompt=$(gum input --prompt "AI> " --placeholder "Ask a question...") || return
  [[ -n "$prompt" ]] || return

  command opencode run \
    --agent plan \
    --model deepseek/deepseek-flash \
    "请简短回答：$prompt" | command glow -
}
