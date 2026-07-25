extends Area2D

var mouse_inside: bool
@export var feather_count: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	#Highlight
	$Regular.visible = false
	$Highlight.visible = true
	mouse_inside = true;

func _on_mouse_exited():
	$Regular.visible = true
	$Highlight.visible = false
	mouse_inside = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and mouse_inside:
			spawn_feathers()

func spawn_feathers():
	for i in range(0, feather_count):
		FeatherManager.add_feather()
		pass
