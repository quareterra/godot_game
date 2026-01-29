extends CharacterBody2D
var speed = 2000

func _process(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta
	move_and_slide()
