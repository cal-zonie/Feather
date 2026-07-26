extends Node

var mouse_inside: bool = false
var lever_state: bool = false
var time_since_feather: float
@export var feather_manager: FeatherManager
@export var feather_rate: float = 0.25

# Called when the node enters the scene tree for the first time.
func _ready():
	$Lever/Color.color = Color.DARK_RED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lever_state:
		time_since_feather += delta
		if time_since_feather >= feather_rate:
			time_since_feather = 0
			feather_manager.add_feather()

func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and mouse_inside:
			toggle_lever()

func toggle_lever():
	if lever_state == false:
		lever_state = true
		$Lever/Color.color = Color.RED
	elif lever_state == true:
		lever_state = false
		$Lever/Color.color = Color.DARK_RED
	
