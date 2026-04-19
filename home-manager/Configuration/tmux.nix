{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile /home/chan/.config/home-manager/Configuration/Dotfiles/tmux.conf;
  };
}
