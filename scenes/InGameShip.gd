# Represents In-Game player ship (its visuals and mechanics such as shooting,
# moving around, etc). Used by upper +Ship+ node to connect ship to in-game inputs
extends CharacterBody2D

var stats: ShipStats = null

# INITIALIZATION LOGIC
# --------------------
func initialize(instance_stats: ShipStats):
	stats = instance_stats

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

func move(delta: float, input_vector: Vector2):
	_set_velocity_and_rotation(delta, input_vector)

# PHYSICS PROCESSING
# ------------------
func _physics_process(delta: float) -> void:	
	move_and_slide()
