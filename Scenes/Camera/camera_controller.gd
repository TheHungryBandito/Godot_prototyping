class_name CameraController
extends Node2D

@export var speed: float = 1000
@export var min_zoom: float = 0.25
@export var max_zoom: float = 5.0
@export var zoom_factor: float = 0.1
@export var zoom_duration: float = 0.2
@export var drag_sensitivity: float = 1.0

var _zoom_level = 1.0
var tween: Tween = null

@onready var camera2D: Camera2D = get_node("Camera2D")

func _ready():
	_set_zoom_level(_zoom_level)

func _process(delta):
	_handle_movement(delta)

func _input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("middle_click"):
		position -= event.relative * drag_sensitivity / camera2D.zoom
		
func _unhandled_input(event):
	if event.is_action_pressed("camera_zoom_in"):
		_set_zoom_level(_zoom_level + zoom_factor)
	if event.is_action_pressed("camera_zoom_out"):
		_set_zoom_level(_zoom_level - zoom_factor)

func _handle_movement(delta) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("camera_right"):
		velocity.x += 1
	if Input.is_action_pressed("camera_left"):
		velocity.x -= 1
	if Input.is_action_pressed("camera_up"):
		velocity.y -= 1
	if Input.is_action_pressed("camera_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta

func _set_zoom_level(value: float) -> void:
	_zoom_level = clamp(value, min_zoom, max_zoom)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(
		camera2D,
		"zoom",
		Vector2(_zoom_level, _zoom_level),
		zoom_duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.play()
