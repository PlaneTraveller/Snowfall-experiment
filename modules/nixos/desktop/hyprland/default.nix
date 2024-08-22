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

              };

              plugins = [ ];
            };
          };
        };
      };
    };
  };
}
