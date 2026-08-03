{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      fira-code
      nerd-fonts.fira-code
      jetbrains-mono
      font-awesome
      openmoji-color
    ];

    fontconfig.defaultFonts.emoji = [
      "OpenMoji Color"
    ];
  };
}
