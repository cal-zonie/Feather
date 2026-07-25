extends Area2D

var mouse_inside: bool
@export var feather_count: int
@export var feather_manager: FeatherManager

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	mouse_inside = true;

func _on_mouse_exited():
	mouse_inside = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and mouse_inside:
			#Highlight
			#$Regular.visible = false
			#$Highlight.visible = true
			spawn_feathers()

func spawn_feathers():
	for i in range(0, feather_count):
		feather_manager.add_feather()
		pass
