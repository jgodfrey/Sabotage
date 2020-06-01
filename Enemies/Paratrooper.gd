extends Node2D

var velocity = Vector2()

func start(pos, speed):
	position = pos
	velocity = Vector2.DOWN * speed

func _process(delta):
	position += velocity * delta

func _on_Man_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		queue_free()
	elif area.is_in_group("ground"):
		velocity = Vector2.ZERO
		position = Vector2(position.x, Globals.screenSize.y - 7)
		hideParachute()

func _on_Parachute_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		hideParachute()
		velocity = velocity * 2

func hideParachute():
	$Parachute/Sprite.visible = false
	$Parachute/CollisionShape2D.set_deferred("disabled", true)
