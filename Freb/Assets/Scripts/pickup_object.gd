extends Node3D

func pickup(source_player : PlayerCharacter) -> void:
	global_position = source_player.carryNode.global_position
	source_player.carryNode.add_child(self)

func _on_area_3d_body_entered(body):
	if(body is PlayerCharacter):
		pickup(body)
