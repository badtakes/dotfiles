let
  marco = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+NkDSwvNucsykETvfFWTKD7BOioIuzEe/8xWrR1HLy marcoantonio.m@pm.me";

  keys = [marco];
in {
  "client/spotify.age".publicKeys = keys;
}
