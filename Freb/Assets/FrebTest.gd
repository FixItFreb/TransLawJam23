extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player(multiplayer.get_unique_id())
	for peer in multiplayer.get_peers():
		if peer != multiplayer.get_unique_id():
			spawn_player(peer)
	multiplayer.peer_connected.connect(on_peer_connected)
	multiplayer.peer_disconnected.connect(on_peer_disconnected)
	# let's just be silly and spawn a player


func spawn_player(id : int):
	var player_node = preload("res://Freb/Assets/Scripts/PlayerCharacter.tscn").instantiate()
	player_node.set_name(str(id))
	player_node.set_multiplayer_authority(id)
	add_child(player_node)
# Called every frame. 'delta' is the elapsed time since the previous frame.


func on_peer_connected(id : int):
	spawn_player(id)

func on_peer_disconnected(id : int):
	var player_node = get_node(str(id))
	if is_instance_valid(player_node):
		player_node.queue_free()
