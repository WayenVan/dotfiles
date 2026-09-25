# Shell AI entry points. Session logic lives in the shared shell-ai executable.

ai()  { command shell-ai ask "$@"; }
ain() { command shell-ai new "$@"; }
aic() { command shell-ai current "$@"; }
air() { command shell-ai reset "$@"; }
