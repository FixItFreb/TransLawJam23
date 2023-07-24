extends Control

@export var start_options: bool = false
@onready var exit_button: Button = $VBoxContainer/VBoxContainer/ExitButton



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if start_options:
		exit_button.visible = false
	else:
		exit_button.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("game_menu"):
		visible = true

func _on_back_button_pressed() -> void:
	visible = false
	if get_parent().has_method("back_from_options"):
		get_parent().back_from_options()


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_music_slider_value_changed(value: float) -> void:
	SoundManager.music_volume = value
	SoundManager.changeMusicVolume()


func _on_sfx_slider_value_changed(value: float) -> void:
	SoundManager.sfx_volume = value


func _on_sfx_slider_drag_ended(_value_changed: bool) -> void:
	SoundManager.play("res://yook_stuff/sfx/menu03.wav")
