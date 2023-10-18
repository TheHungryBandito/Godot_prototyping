class_name Selector
extends Node2D

signal selected_object_changed(object)

var selected_object : Node2D = null :
	get:
		return selected_object
	set(value):
		selected_object = value
		if value == null:
			selected_object_changed.emit(null)
			return
			
		if !value.has_method("get_object_type"):
			selected_object_changed.emit(null)
			return
			
		selected_object_changed.emit(value)
		
