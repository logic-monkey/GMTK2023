extends AudioStreamPlayer

var song_buffer: AudioStream = null

signal song_loaded
func LoadSong(song: String):
	if not ResourceLoader.exists(song):
		emit_signal("song_loaded")
		return
	song_buffer = load(song)
	emit_signal("song_loaded")
	return
	
signal faded_out
func FadeMusicOut(time := 0.25):
	var tween = get_tree().create_tween()
	tween.tween_method(self,"SetFadeVolume",1.0,0.0, time)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	yield(tween,"finished")
	stop()
	emit_signal("faded_out")
	
func SetFadeVolume(v:float):
	v = clamp(v,0,1)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music box"), linear2db(v))
	
func SwitchToSong(song, fade_time:float = 0.0):
	if song is String:
		if stream and song == stream.resource_path\
				and playing: return
		LoadSong(song)
		if song_buffer == null: return
	elif song is AudioStream:
		if song == stream and playing: return
		song_buffer = song
	else:
		return
	
	if fade_time > 0.01:
		FadeMusicOut(fade_time)
		yield(self, "faded_out")
	stop()
	if not _INI.is_loaded:
		yield(_INI,"loaded")
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")

	SetFadeVolume(1)
	stream = song_buffer
	play()
