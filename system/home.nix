{ inputs, config, pkgs, ... }:

{
  # Home
  home.username = "fra";
  home.homeDirectory = "/home/fra";
  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;


  # Packages
  home.packages = with pkgs; [

    # Browser
    inputs.zen-browser.packages."${system}".default

	# Editor
	micro

	# Social
	equibop
	
  ];


  home.sessionVariables = {
    EDITOR = "micro";
    BROWSER = "firefox";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  # Reload system units
  systemd.user.startServices = "sd-switch";
}
