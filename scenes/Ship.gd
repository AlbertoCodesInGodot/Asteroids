extends Node2D

@export var stats: ShipStats

func _ready():
	_setup_in_game_ship($InGameShip)
	_setup_screen_wrapper()

# SETUP LOGIC
# -----------
func _setup_in_game_ship(ship):
	# Initialize new ship with stats
	ship.initialize(stats)

func _setup_screen_wrapper():
	$ScreenWrapper.initialize(self, $InGameShip, func aux(ship): _setup_in_game_ship(ship))

# PHYSICS PROCESSING
# ------------------
func _move_in_game_ship(delta: float):
	$InGameShip.move(delta, Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up"))

# DELTA PROCESSING (LOGIC PER FRAME)
# ----------------------------------
func _process(delta: float) -> void:
	_move_in_game_ship(delta)
	$ScreenWrapper.screen_wrap()
