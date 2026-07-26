extends Node

@export var template_box: PackedScene
var speed: float
var timer: float
var box_spawn_timer: float
var required_feathers

signal on_submit_box(feather_count: int, required_feathers: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = Manager.get_conveyor_speed()
	#box_spawn_timer = Manager.get something
	box_spawn_timer = Manager.get_box_rate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	if timer < 0:
		timer = box_spawn_timer
		add_box()

	for box in $Boxes.get_children():
		box.position.x += speed * delta

func add_box():
	var new_box = template_box.duplicate(true).instantiate()
	new_box.finish.connect(submit_box)
	$Boxes.add_child(new_box)

func submit_box(feather_count: int, required_feathers: int):
	on_submit_box.emit(feather_count, required_feathers)
