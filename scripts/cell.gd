@tool
class_name Cell2D
extends RigidBody2D

@export var default_speed = 400.0
var speed = default_speed
@export var mama: Node2D = null
@export var time_to_replicate = 2.0
@export var time_to_die = 100.0
@export var dist_to_mama_min = 50.0
@export var dist_to_mama_max = 100.0

var is_fed = false
var death_timer = 0.0
var replication_timer = 0.0
var current_size: float = 2.0 

func _init():
	is_fed = false
	gravity_scale = 0.0
	linear_damp = 6.0
	angular_damp = linear_damp

func make_big():
	speed = default_speed * 0.25
	$CollisionShape2D.scale = Vector2(1.5, 1.5)

func make_default_size():
	speed = default_speed
	$CollisionShape2D.scale = Vector2(1.0, 1.0)

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
	var nearest_food = get_nearest_food()
	if nearest_food != null and global_position.distance_squared_to(nearest_food.global_position) < pow(200, 2):
		dir = (nearest_food.global_position - global_position).normalized()
		apply_central_force(dir * speed)
	else:
		if (dist > dist_to_mama_max):
			apply_central_force(dir * speed)
		elif (dist < dist_to_mama_min):
			apply_central_force(-dir * speed * (1 / dist) * dist_to_mama_min)
	
	

func replicate() -> void:
	make_default_size()
	var replicant = clone()
	replicant.global_position = global_position
	replicant.mama = mama
	var properties_to_copy = ["gravity_scale", "linear_damp", "angular_damp", "mass", "speed", "speed", "mama", "time_to_replicate"]
	replicant.replication_timer = randf()
	replicant.is_fed = false
	for prop in properties_to_copy:
		replicant.set(prop, self.get(prop))

	var throw_speed = 50000
	var dir = Vector2.from_angle(randf() * PI * 2)
	apply_central_force(dir * throw_speed)
	replicant.apply_central_force(-dir * throw_speed)
	
	get_parent().add_child(replicant)

func clone() -> RigidBody2D:
	return load(scene_file_path).instantiate()

func get_nearest_food() -> Node2D:
	var foods = get_tree().get_nodes_in_group("food")
	if foods.is_empty():
		return null
	var nearest_food: Node2D = null
	var min_dist_squared = INF
	for food in foods:
		var dist_sq = global_position.distance_squared_to(food.global_position)
		if dist_sq < min_dist_squared:
			min_dist_squared = dist_sq
			nearest_food = food
	return nearest_food
