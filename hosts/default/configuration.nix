{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "/home/fosto/.config/nixos/modules/nixos/opengl.nix"
      "/home/fosto/.config/nixos/modules/nixos/nvidia.nix"
      "/home/fosto/.config/nixos/modules/nixos/bluetooth.nix"
      "/home/fosto/.config/nixos/modules/home-manager/steam.nix"
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      enable = true;
      efiSupport = true;
      useOSProber = true;
    };
  };
  networking.hostName = "nixos"; # Define your hostname.
  networking.firewall = {
   enable = true;
   allowedTCPPortRanges = [
     { from = 1714; to = 1764; } # KDE Connect
   ];
   allowedUDPPortRanges = [
     { from = 1714; to = 1764; } # KDE Connect
   ];
 };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  boot.initrd.kernelModules = [ "i915" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
 # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.setupCommands = "krunner -d";
  security.pam.services.login.enableKwallet = true;
  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "it";
      variant = "";
    };
  };

  # Configure console keymap
  console.keyMap = "it2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.fosto = {
    isNormalUser = true;
    description = "fosto";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      helix
    ];
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "fosto" = import ./home.nix;
    };
    
  };
  # Allow unfree packages:
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [  
  home-manager
  helix # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
  system.stateVersion = "23.11"; # Did you read the comment?

}
