class_name IdleState
extends State

@export var character: CharacterBody2D = null

var move_direction: Vector2
var wander_time: float = 10.0

func randomize_wander():
	move_direction = Vector2(randi_range(-1, 1), randi_range(-1, 1))
	wander_time = randf_range(1, 3)

func enter():
	randomize_wander()
	
func update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	
func physics_update(delta: float):
	if character:
		
