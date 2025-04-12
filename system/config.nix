
{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./drives.nix
      inputs.home-manager.nixosModules.default
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Hostname
  networking.hostName = "nix";


  # Home manager
  home-manager = {
  	extraSpecialArgs = { inherit inputs;};
  	users = {
  		"fra" = import ./home.nix;
  	};
  };


  # NetworkManager
  networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone = "Europe/Rome";


  # Experimental Nix Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


  # Configure keymap in X11
  services.xserver.xkb.layout = "us";


  # Pipewire
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  # Define a user.
  users.users.fra = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };


  # Nvidia
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
  	graphics.enable = true;
  	nvidia = {
  		modesetting.enable = true;
  		open = true;
  		nvidiaSettings = true;
  		package = config.boot.kernelPackages.nvidiaPackages.beta;
  	};
  };


  # AllowUnFree
  nixpkgs.config.allowUnfree = true;


  # System Version
  system.stateVersion = "24.11"; # Did you read the comment?

}

