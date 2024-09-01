{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.desktop.hyprland;
in {
  options.literacy.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable or disable hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    services.gnome.gnome-keyring.enable = true;
    environment = {
      # plasma5.excludePackages = [ pkgs.kdePackages.systemsettings ];
      # plasma6.excludePackages = [ pkgs.kdePackages.systemsettings ];
    };

    services.xserver = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
        # theme = "chili";
        # package = pkgs.sddm;
      };

    };

    #== Home Manager
    literacy.home = {
      extraOptions = {
        wayland = {
          windowManager = {
            hyprland = {
              enable = true;
              xwayland.enable = true;
              settings = {
                #== General Settings
                general = { no_cursor_warps = false; };
                decoration = { };
                animations = { };
                input = {
                  layout = "us";
                  variant = "colemak";
                  options = "caps:escape";
                  follow_mouse = 1;
                  mouse_refocus = false;
                  repeat_delay = 250;
                  repeat_rate = 64;
                  touchpad = {
                    natural_scroll = true;
                    disable_while_typing = true;
                  };
                  sensitivity = 0.3;
                  force_no_accel = 0;
                };
                gestures = {
                  workspace_swipe = true;
                  workspace_swipe_distance = 100;
                  workspace_swipe_fingers = 3;
                };
                groups = { };
                misc = { };
                binds = { };
                xwayland = { };
                opengl = { };
                cursor = { };

                #== Layouts
                master = {
                  new_is_master = false;
                  orientation = "center";
                  special_scale_factor = 0.618;
                  always_center_master = true;
                };

                dwindle = {
                  pseudotile =
                    true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                  preserve_split = true; # you probably want this
                  # smart_split = true
                  # use_active_for_splits = false
                  force_split = 2;
                  default_split_ratio =
                    1.236; # default split ratio for new windows
                };

                #== Workspaces
                workspace = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
                #== Key bindings
                "$mod" = "SUPER";
                bind = [
                  #== Basic window manipulation
                  "$mainMod, T, togglefloating" # toggle the window on focus to float
                  "$mainMod, F, fullscreen"
                  "$mainMod, n, movefocus, l"
                  "$mainMod, i, movefocus, r"
                  "$mainMod, u, movefocus, u"
                  "$mainMod, e, movefocus, d"

                  "$mainMod_SHIFT, I, swapwindow, r"
                  "$mainMod_SHIFT, N, swapwindow, l"
                  "$mainMod_SHIFT, E, swapwindow, d"
                  "$mainMod_SHIFT, U, swapwindow, u"

                  # Scroll through existing workspaces with mainMod + scroll
                  "$mainMod, mouse_down, workspace, e+1"
                  "$mainMod, mouse_up, workspace, e-1"

                ] ++ (
                  #== Workspaces
                  # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
                  builtins.concatLists (builtins.genList (i:
                    let ws = i + 1;
                    in [
                      "$mod, code:1${toString i}, workspace, ${toString ws}"
                      "$mod SHIFT, code:1${toString i}, movetoworkspace, ${
                        toString ws
                      }"
                    ]) 9));

                #== Mouse bindings
                bindm = [
                  # Move/resize windows with mainMod + LMB/RMB and dragging
                  "$mainMod, mouse:272, movewindow"
                  "$mainMod, mouse:273, resizewindow"
                ];

              };
              extraConfig = {
                #== Submaps
              };

              plugins = [ ];
            };
          };
        };
      };
      packages = with pkgs; [ wl-clipboard networkmanagerapplet alsa-utils ];
    };

  };
}
