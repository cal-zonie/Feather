extends Node

var feathers: Array[Feather]
var max_z = 0

@export var BASE_FEATHER: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		add_feather()
	
	if Input.is_action_just_released("left_click"):
		for feather in feathers:
			feather.release()

func add_feather():
	var newFeather: Feather = BASE_FEATHER.duplicate(true).instantiate()
	newFeather.on_pickup.connect(pickup_feather)
	add_child(newFeather)
	feathers.append(newFeather)

func pickup_feather(feather):
	for f in feathers:
		feather.z_index = max_z
		max_z += 1
	pass
