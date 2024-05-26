extends Node2D
var pillow = preload("res://scenes//pillowbody.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = pillow.instantiate()
	instance.position = Vector2(500, 0)
	add_child(instance)
