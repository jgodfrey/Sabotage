extends Area2D

var speed = 300
var velocity = Vector2()

func start(pos, dir):
	position = pos
	velocity = Vector2(0, -speed).rotated(dir)

func _process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
