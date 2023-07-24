extends Node3D

@export var is_moving : bool = false
@export var down_speed : float = -1.0
@export var min_scale : float = 1.0
@export var max_scale : float = 3.0
var rot_x : float = 0.0
var rot_y : float = 0.0
var rot_z : float = 0.0
var rot_amount : float = 0.05

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scale_amount = randf_range(1, 3)
	scale.x = scale_amount
	scale.y = scale_amount
	scale.z = scale_amount
	rot_x = randf_range(-rot_amount, rot_amount)
	rot_y = randf_range(-rot_amount, rot_amount)
	rot_z = randf_range(-rot_amount, rot_amount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving:
		global_position.y += down_speed * delta
		#rotation.x += rot_x
		#rotation.y += rot_y
		rotation.z += rot_z


func _on_timer_timeout() -> void:
	queue_free()
