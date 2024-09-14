final: prev: {
  postman = prev.postman.overrideAttrs (old: {
    src = final.fetchurl {
      url = "https://dl.pstmn.io/download/latest/linux_64";
      sha256 = "sha256-l5lGBv1Y7ZX7wRFNww2YrDm/jsW5e30mEHOjlI87gRY=";

      name = "${old.pname}-latest.tar.gz";
    };
  });
}
