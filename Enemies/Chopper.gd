extends Area2D

onready var paratrooper = preload("res://Enemies/Paratrooper.tscn")
var velocity = Vector2()
onready var world = get_parent().get_parent()

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
		area.queue_free()
		queue_free()
