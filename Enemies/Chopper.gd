extends Area2D

var velocity = Vector2()

func start(pos, dir, vel):
	position = pos
	velocity = vel * dir
	if dir == Vector2.LEFT:
		$Sprite.flip_h = true
		rotation_degrees = -5
	else:
		rotation_degrees = 5

func _process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Chopper_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		queue_free()
