{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    initExtra = ''
      if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
        source ~/.nix-profile/etc/profile.d/nix.sh
      fi

      if [ -z "$TMUX" ]; then
        tmux attach || tmux new-session
      fi

      eval "$(zoxide init zsh)"

      cd() {
        if (( $# == 0 )); then
          builtin cd ~ || return
        elif [[ -d $1 ]]; then
          builtin cd "$1" || return
        else
          if ! z "$@"; then
            echo "Error: Directory not found"
            return 1
          fi
        fi
      }

      PROMPT="%F{#d65d0e}>%f "
    '';
  shellAliases = {
  ls = "eza --tree --level=2 --icons --group-directories-first";
  ll = "eza --tree --level=2 --icons --long --group-directories-first";
  lt = "eza --tree --icons --group-directories-first";
  };
  };

  home.packages = with pkgs; [
    zsh
    zoxide
    eza
    tmux
  ];
}
