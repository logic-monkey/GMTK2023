extends ColorRect

func _on_time_to_autofade_timeout():
	_FADER.FadeTo("res://addons/pixel_art/pixel_title.tscn")

func _input(event):
	if not $time_before_can_leave.is_stopped(): return
	if event.is_pressed():
		$time_to_autofade.paused = true
		_on_time_to_autofade_timeout()
