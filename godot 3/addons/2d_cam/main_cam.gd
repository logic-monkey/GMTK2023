extends Node2D

func _ready():
	yield(get_tree(), "idle_frame")
	_CAM.connect("dolly_changed", self, "_on_dolly_changed")
	_on_dolly_changed()
	
var changing_dolly := false
func _on_dolly_changed():
	if _CAM.dolly:
		if changing_dolly: return
		changing_dolly = true
		_CAM.dolly.remote_path = get_path()
		_CAM.dolly.force_update_cache()
		changing_dolly = false
