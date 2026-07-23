class_name Feather
extends Area2D

var dragging := false
var mouse_offset := Vector2.ZERO
var mouse_inside := false

signal on_pickup(feather)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		position = get_global_mouse_position() + mouse_offset

func _on_mouse_entered():
	mouse_inside = true;

func _on_mouse_exited():
	mouse_inside = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and mouse_inside:
			mouse_offset = position - get_global_mouse_position()
			dragging = true
			#Highlight the feather
			$Regular.visible = false
			$Highlight.visible = true
			on_pickup.emit(self)

func release():
	#Unhighlight the feather
	$Regular.visible = true
	$Highlight.visible = false
	dragging = false
