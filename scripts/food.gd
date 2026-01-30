@tool
class_name Food2D
extends Area2D

func _ready():
	add_to_group("food")


func kill() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Cell2D:
		if not body.is_fed:
			body.is_fed = true
			body.make_big()
			queue_free()
