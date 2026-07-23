extends Node2D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	#TODO: Move this to a manager class of some sort
	get_viewport().physics_object_picking = true
	get_viewport().physics_object_picking_sort = true
	get_viewport().physics_object_picking_first_only = true
	
func _process(delta):
	position = get_viewport().get_mouse_position()
