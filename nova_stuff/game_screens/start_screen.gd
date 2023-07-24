extends Control

var game_screen = preload("res://nova_stuff/game_screens/game_screen.tscn")
@onready var start_screen: VBoxContainer = $StartScreen
@onready var options_screen: Control = $OptionsScreen
@onready var join_screen: Control = $JoinScreen
@onready var address_input: LineEdit = $JoinScreen/VBoxContainer/VBoxContainer/GridContainer/AddressInput
@onready var port_input: SpinBox = $JoinScreen/VBoxContainer/VBoxContainer/GridContainer/PortInput


func back_from_options() -> void:
	SoundManager.play("res://yook_stuff/sfx/menu02.wav")
	start_screen.visible = true

func _on_host_button_pressed() -> void:
	#get_tree().change_scene_to_packed(game_screen)
	SoundManager.play("res://yook_stuff/sfx/menu01.wav")
	ServerManager.init_server()


func _on_options_button_pressed() -> void:
	SoundManager.play("res://yook_stuff/sfx/menu01.wav")
	start_screen.visible = false
	options_screen.visible = true



func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_join_button_pressed() -> void:
	SoundManager.play("res://yook_stuff/sfx/menu01.wav")
	start_screen.visible = false
	join_screen.visible = true


func _on_join_back_button_pressed() -> void:
	SoundManager.play("res://yook_stuff/sfx/menu02.wav")
	start_screen.visible = true
	join_screen.visible = false


func _on_connect_button_pressed() -> void:
	SoundManager.play("res://yook_stuff/sfx/menu01.wav")
	ServerManager.c_local_server_addr = address_input.text
	ServerManager.c_local_server_port = int(port_input.value)
	ServerManager.join_server()
