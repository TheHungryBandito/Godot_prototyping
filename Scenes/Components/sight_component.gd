class_name SightComponent
extends Area2D

signal on_sight_entered(area)
signal on_sight_exited(area)

var objects_in_sight: Array = []

func _ready():
	self.set_collision_layer_value(1, false)
	self.set_collision_layer_value(2, true)
	self.set_collision_mask_value(1, true)
	
func _on_area_entered(area: Area2D):
	if objects_in_sight.has(area.owner):
		return
	objects_in_sight.append(area.owner)
	on_sight_entered.emit(area.owner)

func _on_area_exited(area: Area2D):
	if not objects_in_sight.has(area.owner):
		return
	objects_in_sight.remove_at(objects_in_sight.find(area.owner))
	on_sight_exited.emit(area.owner)
