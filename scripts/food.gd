@tool
class_name Food2D
extends Area2D

func kill() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Cell2D:
		body.is_fed = true
		queue_free()
