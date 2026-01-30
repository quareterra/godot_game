@tool
class_name Cell2D
extends RigidBody2D

@export var speed = 400.0
@export var mama: Node2D = null
@export var time_to_replicate = 2.0
@export var time_to_die = 100.0
@export var dist_to_mama_min = 50.0
@export var dist_to_mama_max = 100.0

var is_fed = false
var death_timer = 0.0
var replication_timer = 0.0

func _init():
	is_fed = false

func _process(delta: float) -> void:
	if is_fed:
		replication_timer += delta
	death_timer += delta
	
	if replication_timer > time_to_replicate:
		replicate()
		replication_timer = 0.0
		is_fed = false
		
	if death_timer > time_to_die:
		queue_free()

func _physics_process(delta: float) -> void:
	var dist = (mama.global_position - global_position).length()
	var dir = (mama.global_position - global_position).normalized()
	if (dist > dist_to_mama_max):
		apply_central_force(dir * speed)
	elif (dist < dist_to_mama_min):
		apply_central_force(-dir * speed * (1 / dist) * dist_to_mama_min)
		
	

func replicate() -> void:
	var replicant = clone()
	replicant.global_position = global_position
	replicant.mama = mama
	var properties_to_copy = ["gravity_scale", "linear_damp", "angular_damp", "mass", "speed", "speed", "mama", "time_to_replicate"]
	replicant.replication_timer = randf()
	replicant.is_fed = false
	for prop in properties_to_copy:
		replicant.set(prop, self.get(prop))
	get_parent().add_child(replicant)

func clone() -> RigidBody2D:
	return load(scene_file_path).instantiate()
