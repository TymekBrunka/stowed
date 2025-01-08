import os
import logging
from pywm import (
    PYWM_MOD_LOGO,
    PYWM_MOD_ALT
)
# from newm.helper import BacklightManager
from newm.layout import Layout
from newm.view import View

logger = logging.getLogger(__name__)

outputs = [
    {
        "name": "eDP-1",
        "scale": 1.0,
        "width": 1920,
        "height": 1080,
        # "mHz": 0,
        "pos_x": 0,
        "pos_y": 0,
    },
    # {"name": "DP-2", "scale": 0.7},
]

# anim_time = 0.2
anim_time = 0
# blend_time = 0.5
blend_time = 0
corner_radius = 0

float_rules = {
    # "opacity": 0.8,
    "float": True,
    # "float_size": (750, 750),
    # "float_pos": (0.5, 0.35),
    "float_size": (600, 100),
    "float_pos": (0.5, 0.15),
}

def rules(view):
    common_rules = {"float": True, "float_size": (600, 100), "float_pos": (0.5, 0.15)}
    float_apps = ("pavucontrol", "rofi") #applications that I want to define as floating
    blur_apps = set() # applications in which I want to have the blur effect
    if view.title in float_apps:
        return common_rules
    if view.title in blur_apps:
        return {"blur": {"radius": 5, "passes": 2}}
    return None

view = {
    "padding": 6,
    "fullscreen_padding": 0,
    "send_fullscreen": False,
    "accept_fullscreen": True,
    "sticky_fullscreen": True,
    "floating_min_size": False,
    # "border_ws_switch": 3,
    "rules": rules,
    "debug_scaling": False,
    "ssd": {"enabled": False},
    "border_ws_switch": 100,
    "color": "#555555",  # change color

    "corner_radius": 6,
}

focus = {
    "color": "#88ddff",  # change color
    "distance": 2,
    "width": 2.5,
    "animate_on_change": False,
    # "anim_time": 0.35,
    "anim_time": 0.35,
    "enabled": True,
}

swipe_zoom = {
    "grid_m": 1,
    "grid_ovr": 0.02,
}

def on_startup():
    # os.system("waybar &")
    os.system("export QT_QPA_PLATFORM=wayland")
    os.system("export MOZ_ENABLE_WAYLAND=1")
    os.system("~/scripts/settheme.sh")
    #fix newm 
    gnome_schema = 'org.gnome.desktop.interface'
    gnome_peripheral = 'org.gnome.desktop.peripherals'
    wm_service_extra_config = (
        f"gsettings set {gnome_peripheral}.mouse natural-scroll false",
        f"gsettings set {gnome_peripheral}.mouse speed -0.3",
        f"gsettings set {gnome_peripheral}.mouse accel-profile 'flat'",
        "gsettings set org.gnome.desktop.wm.preferences button-layout :",
    )

    for config in wm_service_extra_config:
        config = f"{config} &"
        os.system(config)

def on_reconfigure():
    os.system("notify-send newm \"Reloaded configuration\" &")

background = {
    'path': os.environ['HOME'] + '/Pictures/wall_secondary.png'
}

pywm = {
    # 'xkb_model': "macintosh",
    'xkb_layout': "pl",
    # 'xkb_options': "caps:escape",
    "enable_xwayland": True,

    "xcursor_size": 10,
    "texture_shaders": "basic",
    "renderer_mode": "pywm",
    'natural_scroll': True,
}


panels = {
    "bar": {
        "cmd": "waybar",
    },
    "lock": {
        "cmd": "kitty newm-panel-basic lock",
    },
    # "launcher": {
    #     "cmd": "kitty rofi -show drun",
    # }
}

def key_bindings(layout: Layout):

    def compare_views(view):
            view_state = layout.state.get_view_state(view)
            return view_state.j, view_state.i

    def get_sorted_views():
            workspace = layout.get_active_workspace()
            views = sorted(layout.tiles(workspace), key=compare_views)
            return views

    def goto_view(index: int):
        if index == 0:
            return
        views = get_sorted_views()
        num_w = len(views)
        if index > num_w:
            return
        layout.focus_view(views[index - 1])

    def cycle_views(steps: int = 1):
        views = tuple(get_sorted_views())
        current_view = layout.find_focused_view()
        if not current_view or current_view not in views:
            return
        index = (views.index(current_view) + steps) % len(views)
        layout.focus_view(views[index])

    return (
            #default
            ("L-Left", lambda: layout.move(-1, 0)),
            ("L-Down", lambda: layout.move(0, 1)),
            ("L-Up", lambda: layout.move(0, -1)),
            ("L-Right", lambda: layout.move(1, 0)),
            ("L-u", lambda: layout.basic_scale(1)),
            ("L-n", lambda: layout.basic_scale(-1)),
            ("L-t", lambda: layout.move_in_stack(1)),
            ("L-w", lambda: layout.toggle_focused_view_floating()),

            ("L-S-Left", lambda: layout.move_focused_view(-1, 0)),
            ("L-S-Down", lambda: layout.move_focused_view(0, 1)),
            ("L-S-Up", lambda: layout.move_focused_view(0, -1)),
            ("L-S-Right", lambda: layout.move_focused_view(1, 0)),

            ("L-C-Left", lambda: layout.resize_focused_view(-1, 0)),
            ("L-C-Down", lambda: layout.resize_focused_view(0, 1)),
            ("L-C-Up", lambda: layout.resize_focused_view(0, -1)),
            ("L-C-Right", lambda: layout.resize_focused_view(1, 0)),

            ("L-q", lambda: layout.close_focused_view()),

            ("L-p", lambda: layout.ensure_locked(dim=True)),
            ("L-P", lambda: layout.terminate()),
            ("L-C", lambda: layout.update_config()),

            ("L-f", lambda: layout.toggle_fullscreen()),

            ("L-", lambda: layout.toggle_overview()),

            #my own
            ("L-Tab", cycle_views),
            ("L-S-Tab", lambda: cycle_views(-1)),           
            # ("L-Tab", lambda: os.system("grim ~/Pictures/Screenshots/Screenshot-$(ls -1 ~/Pictures/Screenshots | wc -l).png")),
            *(("L-" + str(i), lambda i=i: goto_view(i)) for i in range(1, 11)),
            
            ("L-Return", lambda: os.system("kitty &")),
            ("L-d", lambda: os.system("rofi -show drun &")),
    )
