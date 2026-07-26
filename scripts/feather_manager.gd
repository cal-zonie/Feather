class_name FeatherManager
extends Node

var feathers: Array[Feather]
var max_z = 0
var held_feather: Feather

@export var BASE_FEATHER: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_released("left_click") and held_feather:
		held_feather.release()
		held_feather = null

func add_feather():
	var newFeather: Feather = BASE_FEATHER.duplicate(true).instantiate()
	newFeather.on_pickup.connect(pickup_feather)
	add_child(newFeather)
	feathers.append(newFeather)

func pickup_feather(feather: Feather):
	held_feather = feather
	feather.reparent(self, true)
	move_child(feather, -1)
