# Use the Screen Wrapper Component to wrap 2D nodes to the screen. As a result, when
# a node goes off-screen it will appear in the exact opposite side where it went out.
#
# This is extremely useful for Asteroids, in which both the ship and the rocks behave
# in this exact way (another example of this behavior can be found in Pacman, for ex-
# ample).
#
# Instructions:
# 1. Attach this scene as a direct child node of your 2D scene.
extends Node2D

# SCENE ATTRIBUTES
# ----------------
# Enables/Disables node screen wrapping
@export var mirror_enabled: bool = true

# Tracks screen dimensions in px
var screen_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	_listen_window_resize_signal()
	_update_screen_dimensions()
	

# SCREEN DIMENSION HANDLING
# -------------------------
func _update_screen_dimensions():
	screen_size = get_viewport_rect().size

func _listen_window_resize_signal():
	get_tree().get_root().size_changed.connect(_update_screen_dimensions)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
