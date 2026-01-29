extends RigidBody2D

@export var speed = 400.0
@export var mama: Node2D = null

func _physics_process(delta: float) -> void:
	var dir = (mama.global_position - global_position).normalized()
	apply_central_force(dir * speed)
