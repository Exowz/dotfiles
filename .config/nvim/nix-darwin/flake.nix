{
  description = "Zenful Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
 };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {

      nixpkgs.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.neovim
	  pkgs.git
	  pkgs.cmake
	  pkgs.zsh
	  pkgs.bat
	  pkgs.fzf
	  pkgs.zoxide
	  pkgs.ripgrep
	  pkgs.tree
	  pkgs.lazygit
    pkgs.gh
       ];

       homebrew = {
       	enable = true;
	brews = [
	"mas"
	"openjdk"
	"gcc"
	"git"
	"eza"
	"starship"
	"python"
	"mysql"
	"postgresql"
  "stow"
	];

	casks = [
	"warp"
	"clion"
	"protonvpn"
	"proton-pass"
	"proton-mail"
	"setapp"
	"chatgpt"
	"whatsapp"
	"beeper"
	"notchnook"
	"arc"
	"phpstorm"
	"openemu"
	"vlc"
	"minecraft"
	"lunar-client"
	"visual-studio-code"
	"discord"
	"herd"
	];

	masApps = {
	"Microsoft Word" = 462054704;
	"Microsoft Excel" = 462058435;
	"Microsoft PowerPoint" = 462062816;
	"Proton Pass for Safari" = 6502835663;
	"Affinity Photo 2: Image Editor" = 1616822987;
	"Affinity Publisher 2" = 1606941598;
	"Affinity Designer 2" = 1616831348;
	"Pages" = 409201541;
	"Keynote" = 409183694;
	"Numbers" = 409203825;
	"GarageBand" = 682658836;
	"iMovie" = 408981434;
	"Notability: Notes, PDF" = 360593530;

	};
	onActivation.cleanup = "zap";
	onActivation.autoUpdate = true;
	onActivation.upgrade = true;
       };

      system.defaults = {
	dock.autohide = true;
	dock.tilesize = 46;
	dock.minimize-to-application = true;
	dock.magnification = true;
	dock.largesize = 60;
	dock.persistent-apps = [
	 "/System/Applications/Launchpad.app"
	 "/Applications/Safari.app"
   "/Applications/Arc.app"
	 "/Applications/Proton Mail.app"
	 "/Applications/Setapp/Spark Mail.app"
	 "/Applications/Visual Studio Code.app"
	 "/Applications/Warp.app"
	];
	NSGlobalDomain.AppleInterfaceStyle = "Dark";
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
        programs.zsh.enable = true;
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      security.pam.enableSudoTouchIdAuth = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mbpro" = nix-darwin.lib.darwinSystem {
      modules = [ 
      	configuration
	nix-homebrew.darwinModules.nix-homebrew 
	{
		nix-homebrew = {
			enable = true;
			enableRosetta = true;
			user = "ewankapoor";
			autoMigrate = true;
		};
	}
	];	
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mbpro".pkgs;
 };
}
