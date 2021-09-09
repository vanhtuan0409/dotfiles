{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  /* xdg.configFile.dunst.source = config.lib.file.mkOutOfStoreSymlink ../../config/dunst; */
  /* xdg.configFile.bat.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/bat"; */
}
