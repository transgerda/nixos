# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
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

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  services.zerotierone = {
      enable = true;
      joinNetworks = [
        "68bea79acf00b7b7"
      ];
    };


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

    virtualisation.docker.enable = true;

    services.xserver.videoDrivers = [ "vmware" ];

    virtualisation.vmware.guest.enable = true;

    security.polkit.enable = true;	

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
    extraGroups = [ "networkmanager" "wheel" "docker" ];
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
    LD_LIBRARY_PATH = "/run/current-system/sw/lib";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    lua
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
    pkgs.llvmPackages_18.clangUseLLVM
    thunderbird
    ungoogled-chromium
    google-chrome
    tofi
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
    home-assistant
    glib
    vesktop
    steam
    wireguard-tools
    dirb
    iwd
    iwgtk
    adwaita-icon-theme
    pamixer
    jq
    meson
    btop
    htop
    hyprpaper
    hyprlock
    hyprcursor
    hyprpanel
    lxappearance
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
    figma-linux
    icu
    cliphist
    wl-clipboard
    bluez
    blueman
    wlogout
    swaynotificationcenter
    #kicad
    ags
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
    jamesdsp
    pay-respects
    nmap
    pkgs.libgccjit
    pkgs.gnumake42
    dotnet-sdk_8
    icu
    openssl
    python313Packages.pandas
    python313Packages.dbus-python

    php84Packages.composer 
    php84Extensions.pdo 
    php84Extensions.pdo_mysql
    laravel
    ddev
    mkcert

    jetbrains.rider
    vscode-extensions.hediet.vscode-drawio

    vmware-workstation
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

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * * * martijn ~/.battLowBorderScript.sh"
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

   programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
