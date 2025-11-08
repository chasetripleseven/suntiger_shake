extends Resource
class_name ShakeLayer


@export var amplitude_multiplier: float = 1.0
@export var frequency_multiplier: float = 1.0
@export_group("Position", "position_")
@export var position_amplitude: Vector3 = Vector3.ZERO
@export var position_frequency: Vector3 = Vector3(1.0, 1.0, 1.0)
@export_group("Rotation", "rotation_")
@export var rotation_amplitude: Vector3 = Vector3.ZERO
@export var rotation_frequency: Vector3 = Vector3(1.0, 1.0, 1.0)


var noises: Array[FastNoiseLite]
var position_transform: Vector3 = Vector3.ZERO
var rotation_transform: Vector3 = Vector3.ZERO


func populate_noises() -> void:
	for n: int in range(0, 6):
		var noise: FastNoiseLite = FastNoiseLite.new()
		noise.seed = n
		noises.push_back(noise)


func get_transform(noise_idx: int, frequency: float, time: int) -> float:
	frequency /= 1000
	
	return noises[noise_idx].get_noise_1d(time * frequency) \
		* amplitude_multiplier


func update_layer(time: int) -> void:
	var pos_x: float = get_transform(0, position_frequency.x, time)
	var pos_y: float = get_transform(1, position_frequency.y, time)
	var pos_z: float = get_transform(2, position_frequency.z, time)
	position_transform = Vector3(pos_x, pos_y, pos_z) * position_amplitude
	var rot_x: float = get_transform(3, rotation_frequency.x, time)
	var rot_y: float = get_transform(4, rotation_frequency.y, time)
	var rot_z: float = get_transform(5, rotation_frequency.z, time)
	rotation_transform = Vector3(rot_x, rot_y, rot_z) * rotation_amplitude
