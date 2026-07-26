class_name Box
extends Node2D

var required_feathers: int = 1

signal finish

func _ready():
	required_feathers = randi_range(5, 10)
	$Label.text = str(required_feathers)
	
	#random box sprite
	var sprite_index = randi_range(0, 3)
	get_child(sprite_index).visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > 1350:
		queue_free()
		finish.emit($Feathers.get_children().size(), required_feathers)

func _on_area_entered(area):
	if area is Feather:
		area.on_box = true
		area.call_deferred("reparent", $Feathers)
		if not area.dragging and area.falling:
			area.falling = false

func _on_area_exited(area):
	if area is Feather:
		area.on_box = false
