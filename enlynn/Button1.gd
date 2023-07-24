extends Button

const ServerController = preload("res://enlynn/TestController.tscn")

var server

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_node("/root/TestButtons/Button2").disabled = true
	
	print("Server button was pressed")
	var button1 = get_node("/root/TestButtons/Button")
	button1.disabled  = true
	
	server = ServerController.instantiate()
	button1.add_child(server)
#endfunc()
