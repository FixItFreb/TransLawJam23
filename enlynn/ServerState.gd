extends Node3D

#
# We have some game controller that sets state / loads everything
# - In Lobby State and In Game State
# - Server Manager Singleton launched for host
# - Lobby that lists connected players
# --- Loads the "world" and starts
#

const c_local_server_addr : String           = "127.0.0.1";
const c_max_players       : int              = 5;
const c_local_server_port : int              = 8888; #yolo

var server                : ENetMultiplayerPeer = ENetMultiplayerPeer.new();
var multiplayer_api       : MultiplayerAPI

var connected_clients     : PackedInt32Array = []

var player_info = {} # map of player ids

signal on_player_connect(player_id)
signal on_player_disconnect(player_id)

func _ready():
	server.peer_connected.connect(_on_peer_connected)
	server.peer_disconnected.connect(_on_peer_disconnected)
	server.create_server(c_local_server_port, c_max_players)
	
	multiplayer_api = MultiplayerAPI.create_default_interface()
	multiplayer_api.multiplayer_peer = server
	
	get_tree().set_multiplayer(multiplayer_api, get_path())
	
	# --- 
	# Refuse or Accept Connections
	# set_refuse_new_network_connections(bool)
	# ---
	
	# ---
	# Signals
	# network_peer_connected(int id)
	# network_peer_disconnected(int id)
	#
	# Network of Id = 1, is always the server
	# ---


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if multiplayer_api.has_multiplayer_peer():
		multiplayer_api.poll()

func _on_peer_connected(peer_id):
	print("Player connected with id: ", peer_id)
	on_player_connect.emit(peer_id)

func _on_peer_disconnected(peer_id):
	print("Player disconnected with id: ", peer_id)
	on_player_disconnect.emit(peer_id)
