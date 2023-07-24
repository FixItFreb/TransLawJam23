extends Node

# This is an example of a client trying to connect to a hoster server
# Ideally this would all be UI driver, but oh well...

# User data supplied by the UI ?
const c_local_server_addr : String              = "127.0.0.1";
const c_max_players       : int                 = 5;
const c_local_server_port : int                 = 8888; #yolo

var client                : ENetMultiplayerPeer = ENetMultiplayerPeer.new();
var multiplayer_api       : MultiplayerAPI

# Called when the node enters the scene tree for the first time.
func _ready():
	client.peer_connected.connect(_on_connection_succeeded)
	client.peer_disconnected.connect(_on_connection_failed)
	
	client.create_client(c_local_server_addr, c_local_server_port)
	
	multiplayer_api = MultiplayerAPI.create_default_interface()
	multiplayer_api.multiplayer_peer = client
	
	get_tree().set_multiplayer(multiplayer_api, get_path())
#endfunc()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if multiplayer_api.has_multiplayer_peer():
		multiplayer_api.poll()
	#endif()
#endfunc()

func _on_connection_succeeded(_peer_id):
	print("Successfully connected to the server")
#endfunc()

func _on_connection_failed(_peer_id):
	print("Failed to connect to server!")
#endfunc()
