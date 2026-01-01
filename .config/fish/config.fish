if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    set fish_greeting ""
    alias grep "grep --color=auto"
    alias cat "bat --style=plain --paging=never"
    alias ls "exa --group-directories-first"
    alias ll "exa --group-directories-first -la"
    alias py python3
    alias tree "exa -T"
    alias tm tmux
    alias vim nvim
    alias em "emacs -nw"
    #alias nvim "lvim"
    set -x PATH "$HOME/.cargo/env" $PATH
    set -x PATH "$HOME/.cargo/bin" $PATH
    set -x PATH "$HOME/.local/bin" $PATH
    set -x PATH "$HOME/.nvm/versions/node/v18.12.1/bin" $PATH
    set -x PATH "$HOME/.nvm/versions/node/v20.10.0/bin" $PATH
    set -x PATH "$HOME/.nvm/versions/node/v22.4.1/bin" $PATH
    # Path for Anaconda
    set -x PATH "$HOME/anaconda3/bin" $PATH
    # Path for Laravel
    set -x PATH "$HOME/.config/composer/vendor/bin" $PATH

    # Path for Emacs
    set -x PATH "$HOME/.config/emacs/bin" $PATH

    # Sonar Scanner Tool for Sonnarqube
    set -x PATH "/opt/sonar-scanner-6.2.0.4584-linux-x64/bin" $PATH

    # Flutter

    set -x PATH "$HOME/development/flutter/bin" $PATH

    # Header C/C++
    set -x CPATH /usr/include/opencv4 $CPATH

    # Nvim Swticher
    alias nvchad="env NVIM_APPNAME=NvChad nvim"
    alias lvm="env NVIM_APPNAME=LazyVim nvim"
    alias nvim-kick="env NVIM_APPNAME=kickstart nvim"
    alias nvim-astro="env NVIM_APPNAME=AstroNvim nvim"

    # function nvims
    #   set items "default" "kickstart" "LazyVim" "NvChad" "AstroNvim"
    #   set config (printf "%s\n" $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    #   if test -z "$config"
    #     echo "Nothing selected"
    #     return 0
    #   else if test "$config" = "default"
    #     set config ""
    #   end
    #   env NVIM_APPNAME=$config nvim $argv
    # end

    # bind \ca 'nvims'

    # Path for TexLive LATEX
    set -x PATH /usr/local/texlive/2023/bin/x86_64-linux $PATH
    set -x MANPATH /usr/local/texlive/2023/texmf-dist/doc/man $MANPATH
    set -x INFOPATH /usr/local/texlive/2023/texmf-dist/doc/info $INFOPATH

    set -x PATH /usr/local/texlive/2024/bin/x86_64-linux $PATH
    set -x MANPATH /usr/local/texlive/2024/texmf-dist/doc/man $MANPATH
    set -x INFOPATH /usr/local/texlive/2024/texmf-dist/doc/info $INFOPATH

    # FOR MANUAL
    set -gx MANPATH /usr/share/man $MANPATH
    #Pfetch config
    # JAVA
    # set -x PATH /usr/lib/jvm/java-21-openjdk/bin $PATH
    set -x PF_ASCII arch
    starship init fish | source
end

# function fish_greeting
#   # pfetch
#   # neofetch
#   colorscript random
# end

# pnpm
set -gx PNPM_HOME "/home/natzgun/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
set -gx MAMBA_EXE "/usr/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/home/natzgun/.local/share/mamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
