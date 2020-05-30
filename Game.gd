extends Node2D

onready var chopper = preload("res://Enemies/Chopper.tscn")

func _ready():
	pass

func _process(delta):
	if randi() % 100 == 50:
		spawn_chopper()

func spawn_chopper():
	var val = randi() % 2
	var dir
	var x
	if val:
		x = 0
		dir = Vector2.RIGHT
	else:
		x = 280
		dir = Vector2.LEFT

	var c = chopper.instance()
	c.start(Vector2(x, 10 + randi() % 100), dir, 50 + randi() % 50)
	add_child(c)
