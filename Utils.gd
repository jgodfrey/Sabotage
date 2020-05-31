extends Node

onready var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func getRandomIntBetween(minVal, maxVal):
	return rng.randi_range(minVal, maxVal)

func getRandomFloatBetween(minVal, maxVal):
	return rng.randf_range(minVal, maxVal)

func getRandomBoolValue():
	return rng.randi() % 2 == 1

func getRandomLeftOrRightVector():
	if getRandomBoolValue():
		return Vector2.RIGHT
	else:
		return Vector2.LEFT

# Return 1 or -1
func getRandomDirection():
	return (randi() & 2) - 1
