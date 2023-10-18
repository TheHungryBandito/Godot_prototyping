class_name MovementComponent
extends Node2D

@export var moveable : Node2D = null

func move(delta: float, speed: float, destination: Vector2):
	moveable.position += (destination - moveable.position).normalized() * speed * delta



