class_name SelectableComponent
extends Area2D

@export var selectable : Node2D = null

@onready var main = get_tree().root.get_node("Main")
@onready var selector : Selector = main.get_node("World/Selector")

var is_selected : bool :
	get:
		return selector.selected_object == selectable
	
func _input_event(viewport, event: InputEvent, shape_idx):
	if event.is_action_pressed("right_click"):
		if selector.selected_object == selectable:
			selector.selected_object = null
		else:
			selector.selected_object = selectable
		
	
