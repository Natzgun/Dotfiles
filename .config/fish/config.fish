if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source 
  set fish_greeting ""
  alias grep "grep --color=auto"
  alias cat "bat --style=plain --paging=never"
  alias ls "exa --group-directories-first"
  alias ll "exa --group-directories-first -la"
  alias py "python3"
  alias tree "exa -T"
  alias tm "tmux"
  alias vim "nvim"
  alias em "emacs -nw"
   #alias nvim "lvim"
  set -x PATH  "$HOME/.cargo/env" $PATH
  set -x PATH  "$HOME/.cargo/bin" $PATH
  set -x PATH  "$HOME/.local/bin" $PATH
  set -x PATH  "$HOME/.nvm/versions/node/v18.12.1/bin" $PATH
  set -x PATH  "$HOME/.nvm/versions/node/v20.10.0/bin" $PATH

  # Path for Laravel
  set -x PATH "$HOME/.config/composer/vendor/bin" $PATH

  # Path for Emacs
  set -x PATH "$HOME/.config/emacs/bin" $PATH

  # Path for TexLive LATEX
  set -x PATH "/usr/local/texlive/2023/bin/x86_64-linux" $PATH
  set -x MANPATH "/usr/local/texlive/2023/texmf-dist/doc/man" $MANPATH
  set -x INFOPATH "/usr/local/texlive/2023/texmf-dist/doc/info" $INFOPATH
   #Pfetch config
  set -x PF_ASCII arch
  starship init fish | source
end

function fish_greeting
  pfetch
  # neofetch
end
