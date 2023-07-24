extends Node

#
# A lobby represents pregrame state where we are waiting for all
# the players to join the game.
#

const c_server_id: int = 1 # server id is always 1

const c_initial_message = { 
	message = "Hello! Welcome to Enlynn's scuffed gamejam server!" 
};

const Player = preload("res://enlynn/player/Player.tscn")

var player_info = {} # map of player ids

func _player_connect(id):
	pass
	
func _player_disconnected(id):
	pass

func _connected_ok():        # called only on client
	pass

func _server_disconnected(): # server kicked the client, show error and abort	
	pass
	
func _connected_fail():      # failed to connect, abort
	pass
	
@rpc("any_peer", "reliable", "call_remote")
func register_player(info):
	var id = get_tree().get_rpc_sender_id()
	player_info[id] = info
	
	# TODO(enlynn): call function to update lobby UI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@rpc("any_peer", "reliable", "call_remote")
func preconfigure_game():
	# pause to give time for players to sync, unpause will
	# occur in a post-configure step
	get_tree().set_pause(true) 
	
	var self_peer_id = get_tree().get_network_unique_id()
	
	#
	# NOTE(enlynn): As a multiplayer game, each player gets a 
	# copy of all other players in the game. The following code
	# creates the game world, instanstiates the server player, 
	# and each player that has connected to the game.
	#
	# From this, it seems like this function should be called
	# when the host launches the game.
	#
	
	#
	# NOTE(enlynn): I don't actually know how "game" scenes work
	#
	# Load world
	# var world = load(which_level).instantiate()
	# get_node("/root").add_child(world)
	#
	
	# Load the host
	var host = Player.instantiate()
	host.set_name(str(self_peer_id))
	host.set_multiplayer_authority(self_peer_id)
	get_node("/root/world/players").add_child(host)
	
	# The demo example then iterates over player_info from Lobby
	# and does the same thing as the server player!
	for player in player_info:
		var player_node = Player.instantiate()
		player_node.set_name(str(player))
		player_node.set_multiplayer_authority(player)
		get_node("/root/world/players").add_child(player_node)
	#endfor()
	
	rpc_id(c_server_id, "done_preconfiguring")
#endfunc()
	
var players_done = [] # track the number of players that have loaded the world
@rpc("any_peer", "reliable", "call_remote")
func done_preconfiguring():
	var sender = get_tree().get_rpc_sender_id()
	
	# quick verifications to make sure everything tiptop
	assert(get_tree().is_netword_server())
	assert(sender in player_info) # needs the player info 
	assert(not sender in players_done)
	
	players_done.append(sender)
	
	if players_done.size() == player_info.size():
		rpc("postconfigure_game")
	#endif()
#endfunc()

@rpc("any_peer", "reliable", "call_remote")
func postconfigure_game():
	# only the server can signal we are done loading...
	if get_tree().get_rpc_sender_id() == c_server_id:
		get_tree().set_pause(false)
	#endif()
#endfunc()
