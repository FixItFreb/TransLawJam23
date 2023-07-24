extends Control

var game_screen = preload("res://nova_stuff/game_screens/game_screen.tscn")
@onready var start_screen: VBoxContainer = $StartScreen
@onready var options_screen: Control = $OptionsScreen
@onready var join_screen: Control = $JoinScreen
@onready var address_input: LineEdit = $JoinScreen/VBoxContainer/VBoxContainer/GridContainer/AddressInput
@onready var port_input: SpinBox = $JoinScreen/VBoxContainer/VBoxContainer/GridContainer/PortInput

var game_world = preload("res://Freb/Assets/FrebTest.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func back_from_options() -> void:
	SoundManager.play("res://yook_stuff/sfx/menu02.wav")
	start_screen.visible = true

func _on_host_button_pressed() -> void:
	#get_tree().change_scene_to_packed(game_screen)
	if MultiplayerManager.start_server():
		get_tree().change_scene_to_packed(game_world)

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
	MultiplayerManager.start_client(address_input.text, port_input.value)
	get_tree().change_scene_to_packed(game_world)
	#
