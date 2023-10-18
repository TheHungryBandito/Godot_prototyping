class_name HUD
extends Control

@export var bio_button : Button = null
@export var info_panel : Panel = null
@export var info_title : Label = null
@export var info_desc : Label = null
@export var info_stats : Label = null

@onready var main = get_tree().root.get_node("Main")
@onready var selector : Selector = main.get_node("World/Selector")

func _ready():
	selector.selected_object_changed.connect(_on_selected_object_changed)
	
func _on_selected_object_changed(object):
	if object == null:
		bio_button.hide()
		info_panel.hide()
		info_title.set_text("None")
		info_desc.set_text("None")
		info_stats.set_text("None")
		return
		
	match object.get_object_type():
		"Unit":
			var unit = object as Unit
			bio_button.show()
			info_panel.show()
			info_title.set_text(unit.data.name)
			info_desc.set_text(unit.data.description)
			info_stats.set_text(unit.data.stats)
			return
		"Resource":
			var resource_node = object as ResourceNode
			bio_button.show()
			info_panel.show()
			info_title.set_text(resource_node.data.name)
			info_desc.set_text(resource_node.data.description)
			return
	
	
