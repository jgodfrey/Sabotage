extends Node2D

onready var gun = $Barrel
onready var bullet = preload("res://Bullet/Bullet.tscn")
onready var barrelTip = $Barrel/Position2D
onready var world = get_parent()

var rotationLimit = 80
var speed = 180

func _process(delta):
	var dir = 0
	if Input.is_action_pressed("ui_left"):
		dir += -1

	if Input.is_action_pressed("ui_right"):
		dir += 1

	if Input.is_action_just_pressed("fire"):
		var b = bullet.instance()
		b.start(barrelTip.global_position, gun.rotation)
		world.add_child(b)

	if dir != 0:
		var rot = clamp(gun.rotation_degrees + dir * delta * speed, -rotationLimit, rotationLimit)
		gun.rotation_degrees = rot
