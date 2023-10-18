class_name HealthBarComponent
extends Control

@export var health_component: HealthComponent = null
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar


func _ready():
	_set_max_value(health_component.max_health)
	_set_value(health_component.health)
	health_component.on_health_changed.connect(_set_value)
	health_component.on_max_health_changed.connect(_set_max_value)
	
func _set_value(value: float):
	texture_progress_bar.value = value

func _set_max_value(max_value: float):
	texture_progress_bar.max_value = max_value
