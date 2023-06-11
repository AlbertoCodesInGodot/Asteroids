extends Node2D

@export var stats: ShipLaserStats

var initialized: bool = false

func initialize(position: Vector2, rotation: float):
	$InGameLaser.position = position
	$InGameLaser.rotation = rotation

	_setup_in_game_laser($InGameLaser)
	_setup_screen_wrapper()
	
	initialized = true

# SETUP LOGIC
# -----------
func _setup_in_game_laser(laser):
	# Initialize new ship with stats
	laser.initialize(stats)

func _setup_screen_wrapper():
	$ScreenWrapper.initialize(self, $InGameLaser, func aux(laser): _setup_in_game_laser(laser))

# PHYSICS PROCESSING
# ------------------
func _move_in_game_laser(delta: float):
	$InGameLaser.move(delta)

# DELTA PROCESSING (LOGIC PER FRAME)
# ----------------------------------
func _process(delta: float) -> void:
	if(initialized):
		_move_in_game_laser(delta)
		$ScreenWrapper.screen_wrap()
