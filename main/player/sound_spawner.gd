extends Spatial
class_name SoundSpawner

export(Array, Resource) var sounds: Array

export var volume := 0.0
export var rand_pitch_range := 0.0
export var max_distance := 2000
export var auto_start := false
export var persist := false
export var positional := true

var players: Dictionary = {}

func _ready() -> void:
	if auto_start:
		play_sound()

func _on_player_complete(player: Node) -> void:
	player.queue_free()
	players.erase(player)

func play_sound() -> void:
	var sound_player = AudioStreamPlayer3D.new() if positional else AudioStreamPlayer.new()
	
	if sound_player is AudioStreamPlayer:
		sound_player.volume_db = volume + GlobalSettings.sound_effect_volume
	else:
		sound_player.unit_db = volume + GlobalSettings.sound_effect_volume
	
	sound_player.stream = sounds[randi() % len(sounds)]
	
	if positional:
		sound_player.max_distance = max_distance
	
	sound_player.pitch_scale = 1.0 + (2 * randf() * rand_pitch_range) - rand_pitch_range
	players[sound_player] = true
	
	add_child(sound_player)
	sound_player.connect("finished", self, "_on_player_complete", [sound_player])
	sound_player.play()

func stop_all() -> void:
	for player in players:
		player.queue_free()
	players.clear()
