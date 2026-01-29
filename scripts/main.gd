extends Node2D
var appear_timer = 2.0
var food = load("res://scenes/food.tscn")

func _process(delta: float) -> void:
	appear_timer += delta
	pass
	
