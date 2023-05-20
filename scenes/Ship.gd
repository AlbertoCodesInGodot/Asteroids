extends Node2D

@export var stats: ShipStats

# Duplication of +InGameShip+ child node to create mirror effect
var mirrored_in_game_ships: Array = []

# Tracks the last screen quadrant visited by InGameShip
var last_screen_quadrant = null

func _ready():
	_setup_in_game_ship($InGameShip)
	_setup_mirror_ships()

# SETUP LOGIC
# -----------
func _setup_in_game_ship(ship):
	# Initialize new ship with stats
	ship.initialize(stats)
	
func _setup_mirror_ships():
	# Create mirrors for X & Y axis
	mirrored_in_game_ships.push_back(_mirror_in_game_ship("XMirror"))
	mirrored_in_game_ships.push_back(_mirror_in_game_ship("YMirror"))

# MIRRORING LOGIC
# ---------------
# Returns a clone of InGameShip (with the same stats)
func _mirror_in_game_ship(name: String):
	var mirrored_in_game_ship = $InGameShip.duplicate()

	# Set a easy reference name
	mirrored_in_game_ship.name = name

	_setup_in_game_ship(mirrored_in_game_ship)
	
	add_child(mirrored_in_game_ship)
	
	return mirrored_in_game_ship

# Use ship information to position its X & Y mirrors. Each mirror is positioned at the
# opposite side of the ship, out of the screen, at the same distance of the closer
# viewport border the ship is too
func _place_mirror_in_game_ships():
	var x_mirror = mirrored_in_game_ships[0]
	var y_mirror = mirrored_in_game_ships[1]
	
	x_mirror.rotation = $InGameShip.rotation
	x_mirror.position.y = $InGameShip.position.y

	y_mirror.rotation = $InGameShip.rotation
	y_mirror.position.x = $InGameShip.position.x
	
	if $InGameShip.position.x > (get_viewport().size.x / 2):
		x_mirror.position.x = 0 - (get_viewport().size.x - $InGameShip.position.x)
	else:
		x_mirror.position.x = get_viewport().size.x + ($InGameShip.position.x - get_viewport().size.x)

	if $InGameShip.position.y > (get_viewport().size.y / 2):
		y_mirror.position.y = 0 - (get_viewport().size.y - $InGameShip.position.y)
	else:
		y_mirror.position.y = get_viewport().size.y + ($InGameShip.position.y - get_viewport().size.y)

# Updates +InGameShip+ node position when it reaches the viewport boundaring, setting the
# node exactly at the opposite side of the screen, creating the illusion of screen wrapping
func _wrap_game_ship_in_viewport():
	$InGameShip.position.x = wrapf($InGameShip.position.x, 0, get_viewport_rect().size.x)
	$InGameShip.position.y = wrapf($InGameShip.position.y, 0, get_viewport_rect().size.y)

# PHYSICS PROCESSING
# ------------------
func _move_in_game_ship(delta: float):
	$InGameShip.move(delta, Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up"))

# DELTA PROCESSING (LOGIC PER FRAME)
# ----------------------------------
func _process(delta: float) -> void:
	_move_in_game_ship(delta)
	_wrap_game_ship_in_viewport()
	_place_mirror_in_game_ships()

