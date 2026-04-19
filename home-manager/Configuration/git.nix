{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    #-- Identity
    userName = "Chaniji";
    userEmail = "thecmmac46@gmail.com";

    #-- Extra config
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
      pull.rebase = true;
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      help.autocorrect = 1;
      credential.helper = "store";
    };

    #-- Global ignores
    ignores = [
      ".env"
      ".env.secrets"
      "node_modules"
      ".DS_Store"
      "*.log"
    ];
  };
}
