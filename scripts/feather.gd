class_name Feather
extends Area2D

var dragging := false
var mouse_offset := Vector2.ZERO
var mouse_inside := false

@export var base_floor_y: float = 550
@export var floor_y: float
@export var fall_speed: float = 1
@export var rotation_speed: float = 0.01
@export var float_speed: float = 0.5
@export var rotation_limit: float = 0.5
@export var min_fall_height: float
@export var smooth_constant: float = .25 #must be greater than 0

signal on_pickup(feather)

# Called when the node enters the scene tree for the first time.
func _ready():
	floor_y += base_floor_y + randf_range(-30, 30)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		position = get_global_mouse_position() + mouse_offset
	else:
		#Feather rotates and moves left/right as it falls
		if global_position.y <= floor_y:
			#Slows feather movement down as it reaches rotation limit (to a minimum of a smooth_constant mult)
			var fall_modifier = (abs(rotation_limit) + smooth_constant) - abs(rotation)
			position += Vector2.DOWN * (fall_modifier * fall_speed)
			rotate(fall_modifier * rotation_speed)
			position.x -= fall_modifier * float_speed
			if abs(rotation) > abs(rotation_limit):
				rotation_speed *= -1
				rotation_limit *= -1
				float_speed *= -1

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
	if dragging:
		#Unhighlight the feather
		$Regular.visible = true
		$Highlight.visible = false
		dragging = false
		if global_position.y <= min_fall_height:
			floor_y = base_floor_y + randf_range(-30, 30)
		else: 
			floor_y = min_fall_height
