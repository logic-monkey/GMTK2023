extends CanvasItem

func _ready():
	if OS.has_feature("web"): visible = false
	
