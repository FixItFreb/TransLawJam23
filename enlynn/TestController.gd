extends Node

# Example of a Client that is hosting the server

const ServerController = preload("res://enlynn/Server.tscn")
const LobbyController  = preload("res://enlynn/lobby/Lobby.tscn")

var server_state;
var lobby_state;

enum GameState { IN_LOBBY, PLAYING }
var game_state: GameState = GameState.IN_LOBBY

# Called when the node enters the scene tree for the first time.
func _ready():
	server_state = ServerController.instantiate()
	lobby_state  = LobbyController.instantiate()
	
	get_node("/root").add_child.call_deferred(server_state)
	get_node("/root").add_child.call_deferred(lobby_state)
	
	server_state.on_player_connect.connect(_on_player_connect)
	server_state.on_player_disconnect.connect(_on_player_disconnect)
	
	print("World initialized")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	#endif()
#endfunc()

func _on_player_connect(player_id):
	if game_state == GameState.IN_LOBBY:
		lobby_state.register_player(player_id)
		pass
	#endif
#endfunc	

func _on_player_disconnect(player_id):
	pass
#endfunc
