extends Node2D

var speed = 300
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(pos, dir):
	position = pos
	velocity = Vector2(0, -speed).rotated(dir)

func _process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
