extends Node

enum State {
	SERVER,
	CLIENT,
	NONE
}

var state : State = State.NONE


func _ready() -> void:
	multiplayer.peer_connected.connect(on_peer_connected)
	multiplayer.peer_disconnected.connect(on_peer_disconnected)

func start_server(port : int = 8888, max_clients : int = 5, ip : String = "*"):
	state = State.NONE
	print(multiplayer)
	var peer = multiplayer.multiplayer_peer as ENetMultiplayerPeer
	if not is_instance_valid(peer):
		peer = ENetMultiplayerPeer.new()
	
	peer.close()
	peer.set_bind_ip(ip)
	var err = peer.create_server(port, max_clients)
	
	match err:
		OK:
			state = State.SERVER
			multiplayer.multiplayer_peer = peer
			return true
		ERR_ALREADY_IN_USE:
			push_error("Unable to create server, ", peer, " already has an open connection")
		ERR_CANT_CREATE:
			push_error("Unable to create server")
		_ :
			push_error("Unknown Error")
	return false

func start_client(ip : String, port : int):
	state = State.NONE
	var peer = multiplayer.multiplayer_peer as ENetMultiplayerPeer
	if not is_instance_valid(peer):
		peer = ENetMultiplayerPeer.new()
	
	peer.close()
	var err = peer.create_client(ip, port)
	
	match err:
		OK:
			state = State.CLIENT
			multiplayer.multiplayer_peer = peer
			return true
		ERR_ALREADY_IN_USE:
			push_error("Unable to create client, ", peer, " already has an open connection")
		ERR_CANT_CREATE:
			push_error("Unable to create client")
		_ :
			push_error("Unknown Error")
	return false


func on_peer_connected(id : int):
	print("peer ", id," connected")
	pass

func on_peer_disconnected(id : int):
	print("peer ", id," disconnected")
	pass
	
