{ pkgs, ... }:

{
  services = {
    flatpak.enable = true;
    tailscale.enable = true;
    # tailscale.useRoutingFeatures = "client";

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    xserver.videoDrivers = ["nvidia"];
    displayManager.sddm.wayland.enable = true;

    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}

