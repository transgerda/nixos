{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code
    font-awesome
    jetbrains-mono

    openmoji-color
  ];

  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "OpenMoji Color" ];
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true; 

  boot.loader.systemd-boot = {
  	enable = true;
  	configurationLimit = 3;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  networking.hostName = "bamilaptop"; 

  networking.extraHosts = ''
    0.0.0.0 paradise-s1.battleye.com
    0.0.0.0 test-s1.battleye.com
    0.0.0.0 paradiseenhanced-s1.battleye.com
  '';

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  networking.firewall.allowedTCPPorts = [ 11434 ];

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  services.displayManager.sddm.wayland.enable = true;

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      glibc
      glibc.dev
      libgcc
      gcc.cc
    ];
  };

  virtualisation.docker = {
    enable = true;
  };

  hardware.nvidia-container-toolkit.enable = true;

  security.polkit.enable = true;	

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.martijn = {
    isNormalUser = true;
    description = "martijn";
    extraGroups = [ "networkmanager" "wheel" "docker" "kvm" "libvirtd" "input" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    LD_LIBRARY_PATH = "/run/current-system/sw/lib";
  };

  environment.systemPackages = with pkgs; [
    wget
    lua
    wl-clicker
    lua-language-server
    hollywood
    alacritty
    kitty
    ripgrep
    fd
    fzf
    fish
    zoxide
    atuin
    firefox
    rust-analyzer
    intelephense
    tree
    stylua
    luarocks
    prismlauncher
    rink
    spotify
    stow
    glib
    gobuster
    zulu8
    git
    lazygit
    openssl
    libreoffice
    nodejs
    pm2
    thunderbird
    google-chrome
    pulsemixer
    efibootmgr
    vscode
    bitwarden-desktop
    tree-sitter
    usbutils
    pkg-config
    pavucontrol
    file
    nwg-look
    pkgs.emacsPackages.outlook
    libnotify
    glib
    vesktop
    discord
    wireguard-tools
    dirb
    iwd
    iwgtk
    adwaita-icon-theme
    pamixer
    pyprland
    jq
    meson
    btop
    htop
    hyprpaper
    hyprlock
    hyprcursor
    hyprpanel
    lxappearance
    vulkan-tools
    curl
    rustdesk
    rustc
    cmake
    unzip
    zip
    nautilus
    onedrive
    bibata-cursors
    zsh
    grimblast
    php
    gparted
    figma-linux
    icu
    cliphist
    cura-appimage
    wl-clipboard
    bluez
    blueman
    cava
    heroic
    wine64
    winetricks
    mission-center
    playerctl
    wlogout
    swaynotificationcenter
    kicad
    simulide
    unipicker
    geteduroam-cli
    rofi
    wofi
    cmatrix
    yazi
    pulseaudio
    toilet
    warp
    dunst
    fastfetch
    python314
    yt-dlp
    lsd
    friture
    hypridle
    brightnessctl
    zapzap
    arduino-ide
    xorg.libxkbfile
    jetbrains.rider
    jetbrains.phpstorm
    jamesdsp
    pay-respects
    nmap
    pkgs.libgccjit
    pkgs.gnumake42
    dotnet-sdk_8
    drawio
    icu
    sqlitebrowser
    openssl
    python313Packages.pandas
    python313Packages.dbus-python

    php84Packages.composer 
    php84Extensions.pdo 
    php84Extensions.pdo_mysql
    laravel
    ddev
    mkcert
  ];

  system.stateVersion = "24.11"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.firefox.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  programs.fish.enable = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  services.flatpak.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  services.cron = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

 programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
