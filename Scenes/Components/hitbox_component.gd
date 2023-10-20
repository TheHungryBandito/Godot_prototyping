class_name HitboxComponent
extends Area2D

signal on_hitbox_entered(area)

@export var health_component : HealthComponent = null

func _ready():
	self.set_collision_layer_value(1, true)
	self.set_collision_mask_value(1, true)
	
func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)

func _on_area_entered(area):
	on_hitbox_entered.emit(area)
