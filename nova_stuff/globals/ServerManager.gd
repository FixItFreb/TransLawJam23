extends Node

const ServerController = preload("res://enlynn/Server.tscn")
const LobbyController  = preload("res://enlynn/lobby/Lobby.tscn")

var server_state;
var lobby_state;

enum GameState { IN_LOBBY, PLAYING }
var game_state: GameState = GameState.IN_LOBBY

@export var c_local_server_addr : String = "127.0.0.1";
@export var c_max_players       : int = 5;
@export var c_local_server_port : int = 8888; #yolo

var client : ENetMultiplayerPeer = ENetMultiplayerPeer.new();
var multiplayer_api : MultiplayerAPI

var joined_server : bool = false


func init_server():
	server_state = ServerController.instantiate()
	lobby_state  = LobbyController.instantiate()
	
	get_node("/root").add_child.call_deferred(server_state)
	get_node("/root").add_child.call_deferred(lobby_state)
	
	server_state.on_player_connect.connect(_on_player_connect)
	server_state.on_player_disconnect.connect(_on_player_disconnect)
	
	print("World initialized")

func _on_player_connect(player_id):
	print(str(player_id) + " has connected")
	if game_state == GameState.IN_LOBBY:
		lobby_state.register_player(player_id)
		pass


func _on_player_disconnect(player_id):
	print(str(player_id) + " has disconnected")


func join_server():
	client.peer_connected.connect(_on_connection_succeeded)
	client.peer_disconnected.connect(_on_connection_failed)
	
	client.create_client(c_local_server_addr, c_local_server_port)
	
	multiplayer_api = MultiplayerAPI.create_default_interface()
	multiplayer_api.multiplayer_peer = client
	
	get_tree().set_multiplayer(multiplayer_api, get_path())

func _process(_delta):
	if joined_server:
		if multiplayer_api.has_multiplayer_peer():
			multiplayer_api.poll()


func _on_connection_succeeded(_peer_id):
	joined_server = true
	print(str(_peer_id) + " successfully connected to the server")
#endfunc()

func _on_connection_failed(_peer_id):
	print(str(_peer_id) + " failed to connect to server!")
#endfunc()
