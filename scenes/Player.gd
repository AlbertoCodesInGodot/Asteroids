extends CharacterBody2D

@export var stats: ShipStats

# MOVEMENT LOGIC
# --------------
func _set_rotation(delta: float, rotation_input: float = 0.0):
	if rotation_input != 0:
		rotation += rotation_input * delta * stats.rotation_speed

func _set_velocity(delta: float, acceleration_input: float = 0.0):
	if acceleration_input != 0 and velocity.length() != stats.max_speed:
		var direction = Vector2(0, -1).rotated(rotation)
		velocity += max(0, acceleration_input) * direction * delta * stats.acceleration

func _apply_friction():
	velocity = velocity.lerp(Vector2.ZERO, stats.friction)

func _set_velocity_and_rotation(delta: float, input_vector: Vector2):
	_set_rotation(delta, input_vector.x)
	_set_velocity(delta, input_vector.y)
	_apply_friction()

# INPUT HANDLING
# --------------
func _input_handling(delta):
	# TODO: refactor to a common input handling vector
	_set_velocity_and_rotation(delta, Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up"))

# PHYSICS PROCESSING
# ------------------
func _physics_process(delta: float) -> void:	
	_input_handling(delta)
	move_and_slide()
