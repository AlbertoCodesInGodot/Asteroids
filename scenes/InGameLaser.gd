# Implements the laser movement logic. The $InGameLaser does not perform a _process
# per frame, instead it delegates this responsibility to the +ShipLaser+, responsible of
# controlling the continuous movement of the laser until its lifespan expires
extends Area2D

var stats: ShipLaserStats = null

# INITIALIZATION LOGIC
# --------------------
func initialize(instance_stats: ShipLaserStats):
	stats = instance_stats

# MOVEMENT LOGIC
# --------------
func _set_position(delta: float) -> void:
	var direction = Vector2(cos(rotation), sin(rotation))
	position += direction * stats.speed * delta

func move(delta: float) -> void:	
	_set_position(delta)
