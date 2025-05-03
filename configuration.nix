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
    fira-code
  ];

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

  programs.nix-ld = {
	enable = true;
	libraries = with pkgs; [
		zlib
		libgcc
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
    extraGroups = [ "networkmanager" "wheel" ];
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
    prismlauncher
    rink
    spotify
    stow
    git
    openssl
    libreoffice
    thunderbird
    tofi
    pulsemixer
    vscode
    bitwarden
    usbutils
    signald
    file
    libnotify
    home-assistant
    vesktop
    steam
    btop
    htop
    hyprpaper
    lxappearance
    curl
    unzip
    zip
    nautilus
    onedrive
    zsh
    php
    cliphist
    wl-clipboard
    bluez
    ags
    unipicker
    cmatrix
    toilet
    warp
    dunst
    fastfetch
    lsd
    friture
    hypridle
    brightnessctl
    zapzap
    arduino-ide
    jamesdsp
    thefuck
    nmap
    pkgs.libgccjit
    pkgs.gnumake42
    dotnetCorePackages.sdk_9_0_1xx
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
}
