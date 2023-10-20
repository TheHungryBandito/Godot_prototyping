class_name HitboxComponent
extends Area2D

signal on_hitbox_entered(area)
	
func _on_area_entered(area):
	on_hitbox_entered.emit(area)
