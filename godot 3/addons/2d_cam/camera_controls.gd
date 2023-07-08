extends Node
class_name CameraControls

var dolly setget set_target, get_target

func get_target():
	return dolly
	
signal dolly_changed
func set_target(var t):
	if not t is RemoteTransform2D: return
	dolly = t
	emit_signal("dolly_changed")
	
	
