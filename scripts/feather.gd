class_name Feather
extends Area2D

var dragging := false
var mouse_offset := Vector2.ZERO
var mouse_inside := false
var falling := true
var on_box := false

@export var fall_speed: float = 1
@export var rotation_speed: float = 0.01
@export var float_speed: float = 0.5
@export var rotation_limit: float = 0.5
@export var smooth_constant: float = .25 #must be greater than 0

signal on_pickup(feather)

# Called when the node enters the scene tree for the first time.
func _ready():
	#floor_y += base_floor_y + randf_range(-30, 30)
	#Randomize the starting rotation/position of the feather
	position += Vector2(randf_range(-40, 40), randf_range(-10, 10))
	rotation = randf_range(-rotation_limit, rotation_limit)
	if randf() > 0.5:
		rotation_speed *= -1
		rotation_limit *= -1
		float_speed *= -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + mouse_offset
	else:
		#Feather falls off screen
		if position.y > 650:
			queue_free()
			return
		
		if falling and not on_box:
			#Feather rotates and moves left/right as it falls
			#Slows feather movement down as it reaches rotation limit (to a minimum of a smooth_constant mult)
			var fall_modifier = (abs(rotation_limit) + smooth_constant) - abs(rotation)
			position += Vector2.DOWN * (fall_modifier * fall_speed)
			rotate(fall_modifier * rotation_speed)
			position.x -= fall_modifier * float_speed
			if rotation < rotation_limit and rotation_limit < 0 or rotation > rotation_limit and rotation_limit > 0:
				rotation_speed *= -1
				rotation_limit *= -1
				float_speed *= -1

func _on_mouse_entered():
	#Highlight the feather
	$Regular.visible = false
	$Highlight.visible = true
	mouse_inside = true;

func _on_mouse_exited():
	#Unhighlight the feather
	$Regular.visible = true
	$Highlight.visible = false
	mouse_inside = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and mouse_inside:
			mouse_offset = global_position - get_global_mouse_position()
			dragging = true
			falling = false
			on_pickup.emit(self)

func release():
	if dragging:
		dragging = false
		falling = true
