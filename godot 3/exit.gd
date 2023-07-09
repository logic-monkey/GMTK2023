extends Area2D

var exited := false
export var time_to_fade_out := 3.0

func _on_exit_area_entered(area):
	if exited: return
	exited = true
	
	_MUSIC.FadeMusicOut(time_to_fade_out)
	_IMP.mode = _IMP.TRANSITION
	yield(get_tree().create_timer(time_to_fade_out),"timeout")
	_FADER.FadeTo("res://victory_screen.tscn",Color.white)
