extends Button

const ClientController = preload("res://enlynn/TestClientController.tscn")

var client

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	# Prevent from accidentally selecting the first button
	get_node("/root/TestButtons/Button").disabled  = true
	
	print("Client button was pressed")
	var button2 = get_node("/root/TestButtons/Button2")
	button2.disabled = true
	
	client = ClientController.instantiate()
	button2.add_child(client)
#endfunc()
	
	
