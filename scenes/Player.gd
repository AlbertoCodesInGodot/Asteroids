extends CharacterBody2D

@export var stats: ShipStats
var friction = 0.01

# MOVEMENT LOGIC
# --------------
func _rotate(delta: float, rotation_input: float = 0.0):
	rotation += rotation_input * delta * stats.rotation_speed

func _accelerate(delta: float, acceleration_input: float = 0.0):
	if velocity.length() != stats.max_speed:
		var direction = Vector2(0, -1).rotated(rotation)
		velocity += max(0, acceleration_input) * direction * delta * stats.acceleration

# ENVIRONMENT MOVEMENT LOGIC
# --------------------------
func _friction():
	velocity = velocity.lerp(Vector2.ZERO, friction)

# INPUT HANDLING
# --------------
func _input_handling(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up")

	if input_vector.x != 0:
		_rotate(delta, input_vector.x)

	if input_vector.y != 0:
		_accelerate(delta, input_vector.y)

# PHYSICS PROCESSING
# ------------------
func _physics_process(delta: float) -> void:	
	_input_handling(delta)
	if not Input.is_key_pressed(KEY_UP):
		_friction()
	move_and_slide()
	
