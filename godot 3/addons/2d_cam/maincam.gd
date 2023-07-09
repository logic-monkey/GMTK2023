extends Camera2D

func _ready():
	_CAM.main = self
	yield(get_tree(), "idle_frame")
	reset_smoothing()
