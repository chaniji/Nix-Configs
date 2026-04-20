{ config, pkgs, ... }:
{
    imports = [
     ./packages.nix
     ./zsh.nix   
];
  
  home.username = "chan";
  home.homeDirectory = "/home/chan";
  home.stateVersion = "25.11";  
  programs.home-manager.enable = true;
}
