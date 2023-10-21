class_name Entity
extends Node2D

func get_object_type():
	return "Entity"

func compare_type(compare_type_name: String):
	return get_object_type() == compare_type_name
