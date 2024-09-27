{config, ...}: {
  config = {
    programs.zsh = {
      history = {
        share = true;

        path = "${config.xdg.dataHome}/zsh/zsh_history";

        extended = true;

        save = 100000;
        size = 100000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        ignorePatterns = ["rm *" "pkill *" "kill *" "killall *"];
      };
    };
  };
}
