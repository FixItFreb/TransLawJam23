extends Node

@export var music_volume : float = 0.5
@export var sfx_volume : float = 0.5

var num_players = 4
var bus = "master"
var available = []  # The available players.
var queue = []  # The queue of sounds to play.


func _ready() -> void:
	changeMusicVolume()
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.connect("finished", Callable(self, "_on_stream_finished").bind(p))
		p.bus = bus

func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)


func play(sound_path):
	queue.append(sound_path)


func stopMusic():
	$MusicPlayer.stop()


func changeMusicVolume():
	$MusicPlayer.volume_db = linear_to_db(music_volume)


func _process(_delta):
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		var current_sound = queue.pop_front()
		available[0].stream = load(current_sound)
		available[0].pitch_scale = randf_range(0.9, 1.1)
		available[0].volume_db = linear_to_db(sfx_volume)
		available[0].play()
		available.pop_front()
