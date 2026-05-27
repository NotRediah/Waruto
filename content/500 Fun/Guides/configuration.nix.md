---
dg-publish: true
tags:
  - linux/config
---

```
 # Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
#boot.loader = {
 # efi.canTouchEfiVariables = true;
  #grub.enable = true;
  #grub.efiSupport = true;
  #grub.device = "nodev";
  #grub.useOSProber = true;
#};

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Karachi";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };


  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

  
displayManager = {
  lightdm = {
    enable = true;
    greeters.slick = {
      enable = true;
      draw-user-backgrounds = false;
      extraConfig = ''
      background = /etc/lightdm/forest.jpg
      theme-name = Graphite-Dark
      icon-theme-name = Tela-black-dark
      cursor-theme-name = Adwaita
      draw-user-backgrounds = false
       '';

    };
  };

  # This is the important line:
  defaultSession = "none+i3";
};


    desktopManager.xfce.enable = true;

    # Window Manager: i3
    windowManager.i3.enable = true;
    windowManager.awesome.enable=true;
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };

    # Set CapsLock as Ctrl
    xkbOptions = "caps:ctrl_modifier";
  };


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
  services.xserver.libinput.enable = true;
  
#Shell stuff
  programs.starship.enable = true;

  programs.zsh.enable = true;
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  # Define a user account.
  users.users.zg = {
    isNormalUser = true;
    description = "ZG";
    extraGroups = [ "networkmanager" "wheel" ];
    # Set the default shell for this user to Zsh
    shell = pkgs.zsh;
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.git.enable = true;

  # Add the nh configuration here.
  # Make sure the `flake` path is correct.
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    # Make sure to set this to the correct path where your flake is stored!
    flake = "/etc/nixos/";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# app image
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;



  #fonts

  fonts.packages = with pkgs; [
    # Your other fonts...
    nerd-fonts.jetbrains-mono
  ];

      # You might also want to enable fontconfig if not already enabled
      fonts.fontconfig.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ emacs  lxsession wget htop fastfetch rofi polybarFull feh picom kitty dunst libnotify lxappearance i3-gaps xed-editor pulseaudio xorg.xev xorg.xkbutils xorg.setxkbmap syncthing autotiling betterlockscreen maim xclip brightnessctl tela-icon-theme steam-run unzip efibootmgr gparted  mpv pipx gearlever xorg.xwininfo qbittorrent sct stow yazi eww graphite-gtk-theme rofimoji appimage-run  haskellPackages.greenclip jq qutebrowser microsoft-edge gruvbox-gtk-theme

#extra
koreader stremio vesktop anki-bin audacious audacious-plugins obs-studio
whatsie pomodoro localsend remmina moonlight-qt themix-gui zoom-us 

#wayland
walker nwg-look  mako cliphist swaybg wlsunset hyprlock
  ];

  # Enablling nix flakes  

  nix.settings.experimental-features = [ "nix-command" "flakes" ];




# ====================================================================
  # System Services (managed by systemd)
  # ====================================================================
  systemd.user.services.remmina = {
    enable = false;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  # };

  # List services that you want to enable:
 
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
    networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}


```
