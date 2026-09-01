{ pkgs, ... }:

{
  programs = {
    firefox.enable = true;
    fish.enable = true;
    ydotool.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    waybar = {
      enable = true;
      package = pkgs.waybar;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
            then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        glibc
        glibc.dev
        libgcc
        gcc.cc
        libxkbcommon
        libXi
        libXrandr
        glib

        libXtst
        libX11
        libXext
      ];
    };
  };
}

