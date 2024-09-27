{lib, ...}: let
  inherit (lib) mkAgenixSecret;
in {
  age.identityPaths = ["/home/marco/.ssh/id_ed25519"];

  age.secrets = {
    spotify = mkAgenixSecret true {
      file = "client/spotify.age";
      owner = "marco";
      group = "users";
      mode = "400";
    };
  };
}
