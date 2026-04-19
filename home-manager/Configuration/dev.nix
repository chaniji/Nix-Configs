{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    bun
    jdk21
    docker
    docker-compose
  ];
}
