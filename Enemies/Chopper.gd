extends Area2D

onready var paratrooper = preload("res://Enemies/Paratrooper.tscn")
var velocity = Vector2()
onready var world = get_parent().get_parent()
var dead = false

func start(pos, dir, speed):
	position = pos
	velocity = dir * speed
	if dir == Vector2.LEFT:
		$Sprite.flip_h = true
		rotation_degrees = -5
	else:
		rotation_degrees = 5

func _process(delta):
	position += velocity * delta
	if !dead:
		if Utils.getRandomIntBetween(1, 200) == 25:
			spawnParatrooper()

func spawnParatrooper():
	var p = paratrooper.instance()
	p.start(Vector2(position.x, position.y + 10), 25)
	world.add_child(p)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Chopper_area_entered(area):
	if area.is_in_group("bullet"):
		dead = true
		area.queue_free()
		$Particles2D.emitting = true
		$Sprite.visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		$Timer.start()

func _on_Timer_timeout():
	queue_free()
