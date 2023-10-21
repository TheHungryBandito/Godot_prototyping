class_name StateMachine
extends Node2D

@export var initial_state : State

var cur_state : State
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		states[child.name.to_lower()] = child
		child.transitioned.connect(_on_child_transitioned)
	
	if initial_state:
		initial_state.enter()
		cur_state = initial_state
		
func _process(delta):
	if cur_state:
		cur_state.update(delta)

func _physics_process(delta):
	if cur_state:
		cur_state._physics_update(delta)
		
func _on_child_transitioned(state, new_state_name):
	if state != cur_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if cur_state:
		cur_state.exit()
		
	new_state.enter()
	
	cur_state = new_state
	
