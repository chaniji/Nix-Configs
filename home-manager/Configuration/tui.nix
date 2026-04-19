{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #-- Git
    lazygit

    #-- Docker
    lazydocker

    #-- GitHub
    gh

    #-- SQL
    lazysql

    #-- API
    posting

    #-- Timer/Pomodoro
    timr-tui
  ];
}
