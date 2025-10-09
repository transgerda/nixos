# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code
    font-awesome

    openmoji-color
  ];

  fonts.fontconfig = {
      defaultFonts = {
        emoji = [ "OpenMoji Color" ];
      };
    };


  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Bootloader.
  boot.loader.systemd-boot = {
  	enable = true;
  	configurationLimit = 3;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bamilaptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = "0";

  services.nginx.enable = false;
  services.nginx.virtualHosts."tuwi.ddev.site" = {
    root = "/var/www/html";
  };

  #security.acme = {
    #defaults.email = "m.vanboven@tuwi.nl";
    #acceptTerms = true;
  #};
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
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

    security.polkit.enable = true;	

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.martijn = {
    isNormalUser = true;
    description = "martijn";
    extraGroups = [ "networkmanager" "wheel" "docker" "nginx" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    GDK_SCALE = 2;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    lua
    lua-language-server
    hollywood
    alacritty
    firefox
    tree
    rink
    spotify
    stow
    zulu8
    git
    openssl
    libreoffice
    thunderbird
    ungoogled-chromium
    google-chrome
    tofi
    pulsemixer
    efibootmgr
    vscode
    bitwarden
    usbutils
    pavucontrol
    signald
    file
    nwg-look
    libnotify
    home-assistant
    vesktop
    adwaita-icon-theme
    pamixer
    jq
    btop
    htop
    hyprpaper
    hyprlock
    lxappearance
    curl
    unzip
    zip
    nautilus
    zsh
    grimblast
    php
    icu
    cliphist
    wl-clipboard
    simulide
    unipicker
    rofi
    wofi
    cmatrix
    pulseaudio
    toilet
    warp
    dunst
    fastfetch
    yt-dlp
    lsd
    friture
    hypridle
    brightnessctl
    zapzap
    arduino-ide
    xorg.libxkbfile
    jamesdsp
    thefuck
    nmap
    lsof
    lazygit

    jetbrains.phpstorm
    ddev
    docker_28
    fontforge
    mkcert
    nginx
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
	

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
	withUWSM = true;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * * martijn ~/.battLowBorderScript.sh"
    ];
  };

  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };


  services.ollama = {
    enable = false;
    acceleration = "cuda";
    # Optional: preload models, see https://ollama.com/library
    # loadModels = [ "qwen3:8b" ];
  };

  programs.steam = {
    enable = false;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
