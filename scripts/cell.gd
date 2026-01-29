extends RigidBody2D

@export var speed = 400.0
@export var mama: Node2D = null
@export var time_to_replicate = 2.0

var replication_timer = 0.0

func _process(delta: float) -> void:
	replication_timer += delta
	
	if replication_timer > time_to_replicate:
		replicate()
		replication_timer = 0.0

func _physics_process(delta: float) -> void:
	var dir = (mama.global_position - global_position).normalized()
	apply_central_force(dir * speed)

func replicate() -> void:
	var replicant = clone()
	replicant.global_position = global_position
	replicant.mama = mama
	var properties_to_copy = ["gravity_scale", "linear_damp", "angular_damp", "mass", "speed", "speed", "mama", "time_to_replicate"]
	replicant.replication_timer = randf()
	for prop in properties_to_copy:
		replicant.set(prop, self.get(prop))
	get_parent().add_child(replicant)

func clone() -> RigidBody2D:
	return load(scene_file_path).instantiate()
