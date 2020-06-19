extends Node2D

var velocity = Vector2()
var dead = false
var falling = false

func start(pos, speed):
	position = pos
	velocity = Vector2.DOWN * speed

func _process(delta):
	if !dead:
		var speed = velocity if not falling else velocity * 2.5
		position += speed * delta

func _on_Man_area_entered(area):
	# if we were hit by a bullet, kill the bullet and the paratrooper
	if area.is_in_group("bullet"):
		area.queue_free()
		startDeath()
	# if we were hit by the ground...
	elif area.is_in_group("ground"):
		# if this guy hit the ground without a parachute, kill him
		if !$Parachute/Sprite.visible:
			startDeath()
		# otherwise, hide the parachute and place him on the ground surface
		else:
			velocity = Vector2.ZERO
			position = Vector2(position.x, Globals.screenSize.y - 7)
			hideParachute()
	# if we were hit by another paratrooper
	elif area.is_in_group("man"):
		var parent = area.get_parent()
		# If we're coming in without a parachute and hit another guy on the
		# ground, kill that guy. The "falling" guy will be killed in a later
		# frame when he hits the ground without a parachute...
		if !$Parachute/Sprite.visible && !parent.get_node("Parachute/Sprite").visible:
			parent.startDeath()

func _on_Parachute_area_entered(area):
	# If the parachute was hit with a bullet, remove the parachute and
	# speed up the downward velocity (falling)
	if area.is_in_group("bullet"):
		area.queue_free()
		hideParachute()
		falling = true

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
