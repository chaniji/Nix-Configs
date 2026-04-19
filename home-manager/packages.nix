{ pkgs, ... }:

{
  imports = [
    ./Configuration/git.nix
    ./Configuration/bat.nix 
    ./Configuration/tmux.nix
    ./Configuration/ai.nix
    ./Configuration/dev.nix
    ./Configuration/tui.nix
 ];
 
 home.packages = with pkgs; [ 

  ];

}
