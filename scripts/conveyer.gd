extends Node

@export var template_box: PackedScene

signal on_submit_box(feather_count: int, required_feathers: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		add_box()

func add_box():
	var new_box = template_box.duplicate(true).instantiate()
	new_box.finish.connect(submit_box)
	$Boxes.add_child(new_box)

func submit_box(feather_count: int, required_feathers: int):
	on_submit_box.emit(feather_count, required_feathers)
