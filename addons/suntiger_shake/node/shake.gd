@icon("res://addons/suntiger_shake/assets/suntiger_shake.png")
extends Node3D
class_name Shake


## The [Node3D] to apply the shake to.
@export var target: Node3D

## A [ShakeLayer] describes the transforms used as well as the
## amplitude and frequency of the shaking.
## 
## 
## Multiple [ShakeLayer]s can be used to cover multiple different situations
## such as "idle shake", "gun firing shake", "grenade explosion shake".
@export var layers: Array[ShakeLayer]


var time: int
var final_position_transform: Vector3 = Vector3.ZERO
var final_rotation_transform: Vector3 = Vector3.ZERO


func _ready() -> void:
	for layer: ShakeLayer in layers:
		layer.populate_noises()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time = Time.get_ticks_usec()
	
	final_position_transform = Vector3.ZERO
	final_rotation_transform = Vector3.ZERO
	
	for layer: ShakeLayer in layers:
		layer.update_layer(time)
	
	for layer: ShakeLayer in layers:
		final_position_transform += layer.position_transform
		final_rotation_transform += layer.rotation_transform
	
	target.position = final_position_transform
	target.rotation = final_rotation_transform
