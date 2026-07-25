extends Node

@export var template_box: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		var new_box = template_box.duplicate(true).instantiate()
		$Boxes.add_child(new_box)
