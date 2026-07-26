class_name Box
extends Node2D

@export var speed: float = 0
var required_feathers: int = 1

signal finish

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
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
