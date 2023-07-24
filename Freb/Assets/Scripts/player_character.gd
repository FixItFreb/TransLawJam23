extends StaticBody3D
class_name PlayerCharacter

@export var playerName : String
@export var moveSpeed : float = 0.5
@export var playerNode : Node3D
@export var animPlayer : AnimationPlayer
@export var slimeCol : Color = "b57eff"
@export var multiplayerSynch : MultiplayerSynchronizer
@export var mesh : MeshInstance3D
@export var playerCam : Camera3D

var carrying : Node3D
var carryNode : Node3D

var moveDirection : Vector3 = Vector3.ZERO
var isMoving : bool = false

func set_col(newCol : Color) -> void:
	slimeCol = newCol
	mesh.get_surface_override_material(0).set("albedo_color", slimeCol)

func _ready():
	set_process(is_multiplayer_authority())
	set_physics_process(is_multiplayer_authority())
	set_col(slimeCol)
	playerCam.current = is_multiplayer_authority()
		
	
func _process(delta):
	if(isMoving):
		if(animPlayer.current_animation != "Slime_WALK"):
			animPlayer.play("Slime_WALK")
		playerNode.look_at(playerNode.global_position + moveDirection, Vector3.UP)
	if(!isMoving && animPlayer.current_animation != "Slime_IDLE"):
		animPlayer.play("Slime_IDLE")
		
func _physics_process(delta):
	moveDirection = Vector3.ZERO
	
	if(Input.is_action_pressed("up")):
		moveDirection.z = -1.0
	if(Input.is_action_pressed("down")):
		moveDirection.z = 1.0
	if(Input.is_action_pressed("left")):
		moveDirection.x = -1.0
	if(Input.is_action_pressed("right")):
		moveDirection.x = 1.0
		
	isMoving = moveDirection.length() > 0
	moveDirection = moveDirection.normalized()
	move_and_collide(moveDirection * moveSpeed * delta)
