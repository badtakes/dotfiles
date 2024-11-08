{...}: {
  systemd = let
    timeoutConfig = ''
      DefaultTimeoutStartSec=10s
      DefaultTimeoutStopSec=10s
      DefaultTimeoutAbortSec=10s
      DefaultDeviceTimeoutSec=10s
    '';
  in {
    extraConfig = timeoutConfig;
    user.extraConfig = timeoutConfig;
  };
}
