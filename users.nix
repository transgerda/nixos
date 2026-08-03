{ pkgs, ... }:

{
  users.users.martijn = {
    isNormalUser = true;
    description = "martijn";
    extraGroups = [ "networkmanager" "wheel" "docker" "kvm" "libvirtd" "input" ];
  };
}

