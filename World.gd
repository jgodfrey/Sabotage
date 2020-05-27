extends Node2D

onready var gun = $Barrel
var rotationLimit = 80
var speed = 180

# Called when the node enters the scene tree for the first time.
func _ready():
	var hour = 6
	var minute = 35
	var time = "%02d:%02d" % [hour, minute]
	print(time)
	var v = Vector2(1, 1)
	print(v.angle())
	print(rad2deg(v.angle()))

func _process(delta):
	var dir = 0
	if Input.is_action_pressed("ui_left"):
		dir += -1
	if Input.is_action_pressed("ui_right"):
		dir += 1

	if dir != 0:
		var rot = clamp(gun.rotation_degrees + dir * delta * speed, -rotationLimit, rotationLimit)
		gun.rotation_degrees = rot
