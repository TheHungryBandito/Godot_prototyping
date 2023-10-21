class_name DependencyContainer
extends Node2D

var container: Dictionary = {}
	
func register_dependency(instance: Object, instance_name: String):
	if container.has(instance_name):
		return
	container[instance_name] = instance
	
func get_dependency(instance_name: String) -> Object:
	return container[instance_name]

func has_dependency(instance_name: String) -> bool:
	return container.has(instance_name)
	
func _to_string():
	return "DependencyContainer"
