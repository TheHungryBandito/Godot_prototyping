class_name HitboxComponent
extends Area2D

signal on_hitbox_entered(area)

@export var health_component : HealthComponent = null

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)


func _on_area_entered(area):
	on_hitbox_entered.emit(area)
