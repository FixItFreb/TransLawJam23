extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	# let's just be silly and spawn a player
	var player_node = preload("res://Freb/Assets/Scripts/PlayerCharacter.tscn").instantiate()
	var player = get_tree().get_multiplayer().get_unique_id()
	player_node.set_name(str(player))
	player_node.set_multiplayer_authority(player)
	get_node("/root/FrebTest").add_child.call_deferred(player_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
