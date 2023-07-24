extends Control

var game_screen = preload("res://nova_stuff/game_screens/game_screen.tscn")
@onready var start_screen: VBoxContainer = $StartScreen
@onready var options_screen: Control = $OptionsScreen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func back_from_options() -> void:
	start_screen.visible = true

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_screen)


func _on_options_button_pressed() -> void:
	start_screen.visible = false
	options_screen.visible = true



func _on_exit_button_pressed() -> void:
	get_tree().quit()
