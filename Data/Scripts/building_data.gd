class_name BuildingData
extends Resource

@export var name: String
@export var texture: Texture
@export var unbuilt_texture: Texture
@export var width: int = 1
@export var height: int = 1
@export var resources_required: Dictionary
@export var work_required: int = 1
@export var is_resting_spot: bool = false
@export var recipes: Array[RecipeData]
