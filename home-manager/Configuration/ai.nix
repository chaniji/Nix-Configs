{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gemini-cli
    opencode
    aider-chat
];
}
