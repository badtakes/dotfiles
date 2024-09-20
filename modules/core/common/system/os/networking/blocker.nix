{...}: {
  networking.stevenblack = {
    enable = true;
    block = ["fakenews" "gambling"];
  };
}
