extends Node3D

var strawb = preload("res://nova_stuff/backgrounds/menu_bits/strawberry.tscn")
var cake = preload("res://nova_stuff/backgrounds/menu_bits/choco_cake.tscn")
@onready var path_follow_3d: PathFollow3D = $Path3D/PathFollow3D
var speed : float = 50.0
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(randf_range(0.01, 0.05))
	timer_2.start(randf_range(0.01, 0.05))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow_3d.progress += delta * speed


func _on_timer_timeout() -> void:
	var new_strawb = strawb.instantiate()
	add_child(new_strawb)
	new_strawb.is_moving = true
	new_strawb.min_scale = 1.0
	new_strawb.max_scale = 5.0
	new_strawb.global_position = path_follow_3d.global_position
	timer.start(randf_range(0.1, 0.5))


func _on_timer_2_timeout() -> void:
	var new_cake = cake.instantiate()
	add_child(new_cake)
	new_cake.is_moving = true
	new_cake.min_scale = 5.0
	new_cake.max_scale = 10.0
	new_cake.global_position = path_follow_3d.global_position
	timer_2.start(randf_range(0.1, 0.5))
