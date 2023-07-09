extends Area2D

var collected := false
export var time_to_fade_out := 3.0
func _on_coin_area_entered(area):
	if collected: return
	collected = true
	_MUSIC.FadeMusicOut(1)
	_IMP.mode = _IMP.TRANSITION
	$coin_collect.play()
	$AnimationPlayer.play("collect")
	_GM.emit_signal("game_lose")
	yield(get_tree().create_timer(time_to_fade_out),"timeout")
	_FADER.FadeTo("res://defeat_screen.tscn")
