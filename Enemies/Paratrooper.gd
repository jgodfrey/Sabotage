extends Node2D

var velocity = Vector2()
var dead = false

func start(pos, speed):
	position = pos
	velocity = Vector2.DOWN * speed

func _process(delta):
	if !dead:
		position += velocity * delta

func _on_Man_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		startDeath()
		#queue_free()
	elif area.is_in_group("ground"):
		# if this guy hit the ground without a parachute, kill him
		if !$Parachute/Sprite.visible:
			startDeath()
			#queue_free()
		else:
			velocity = Vector2.ZERO
			position = Vector2(position.x, Globals.screenSize.y - 7)
			hideParachute()
	elif area.is_in_group("man"):
		var parent = area.get_parent()
		if !parent.get_node("Parachute/Sprite").visible:
			parent.startDeath()

func _on_Parachute_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		hideParachute()
		velocity = velocity * 2.5

func hideParachute():
	$Parachute/Sprite.visible = false
	$Parachute/CollisionShape2D.set_deferred("disabled", true)

func startDeath():
	$Timer.start()
	$Particles2D.emitting = true
	$Man/Sprite.visible = false
	$Parachute/Sprite.visible = false
	$Man/CollisionShape2D.set_deferred("disabled", true)
	$Parachute/CollisionShape2D.set_deferred("disabled", true)

func _on_Timer_timeout():
	queue_free()
