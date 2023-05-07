# Represent Ship tecnical specification: speed, fire power, etc.
class_name ShipStats extends Resource

@export var rotation_speed: float
@export var acceleration: float
@export var max_speed: float
@export var friction: float

func _init(p_rotation_speed: float = 0, p_acceleration: float = 0, p_max_speed: float = 0, p_friction: float = 0):
	rotation_speed = p_rotation_speed
	acceleration = p_acceleration
	max_speed = p_max_speed
	friction = p_friction
