extends Node2D
var appear_timer = 0.0
var time_to_appear = 0.2
var food = load("res://scenes/food.tscn")

func _process(delta: float) -> void:
	appear_timer += delta
	if appear_timer > time_to_appear:
		spawn_food()
		appear_timer = 0.0
	
func spawn_food():
	var current_food = food.instantiate()
	current_food.global_position = Vector2(randf(), randf()) * 1000

	add_child(current_food)
