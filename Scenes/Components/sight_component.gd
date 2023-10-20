class_name SightComponent
extends Area2D

signal on_sight_entered(area)
signal on_sight_exited(area)

var objects_in_sight: Array[Node2D] = []

func _ready():
	objects_in_sight.clear()
	
func _on_area_entered(area: Area2D):
	if area.owner == owner:
		return
	if objects_in_sight.has(area.owner):
		return
	objects_in_sight.append(area.owner)
	on_sight_entered.emit(area.owner)

func _on_area_exited(area: Area2D):
	if not objects_in_sight.has(area.owner):
		return
	objects_in_sight.remove_at(objects_in_sight.find(area.owner))
	on_sight_exited.emit(area.owner)

func get_closest() -> Node2D:
	if objects_in_sight.is_empty():
		return null
	var closest = null
	var distance = 9999.00
	var duplicate_array = objects_in_sight.duplicate()
	for visible_object in objects_in_sight:
		if position.distance_to(visible_object.position) < distance:
			distance = position.distance_to(visible_object.position)
			closest = visible_object
	return closest

func get_furthest() -> Node2D:
	if objects_in_sight.is_empty():
		return null
	var furthest = null
	var distance = 0
	var duplicate_array = objects_in_sight.duplicate()
	for visible_object in objects_in_sight:
		if position.distance_to(visible_object.position) > distance:
			distance = position.distance_to(visible_object.position)
			furthest = visible_object
	return furthest

func get_random() -> Node2D:
	if objects_in_sight.is_empty():
		return null
	return objects_in_sight.pick_random()
