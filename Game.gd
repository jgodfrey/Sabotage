extends Node2D

onready var chopper = preload("res://Enemies/Chopper.tscn")
var chopper_count = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$DebugOverlay.add_stat("FPS", Engine, "get_frames_per_second", true)
	$DebugOverlay.add_stat("Choppers", self, "chopper_count", false)

func _process(delta):
	if Utils.getRandomIntBetween(1, 100) == 50:
		if get_tree().get_nodes_in_group("chopper").size() < 4:
			spawn_chopper()

func spawn_chopper():
	var dir = Utils.getRandomLeftOrRightVector()
	var x_pos = 0 if dir == Vector2.RIGHT else Globals.screenSize.x
	var y_pos = Utils.getRandomIntBetween(10, 80)
	var speed = Utils.getRandomIntBetween(50, 100)
	var c = chopper.instance()
	c.start(Vector2(x_pos, y_pos), dir, speed)
	add_child(c)
	chopper_count += 1
