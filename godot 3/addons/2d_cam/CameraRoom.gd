tool
extends Area2D
class_name CameraRoom

export(Rect2) var bounds setget set_bounds, get_bounds
func set_bounds(var r:Rect2):
	$ReferenceRect.rect_position = r.position
	$ReferenceRect.rect_size = r.size
func get_bounds()->Rect2:
	return Rect2($ReferenceRect.rect_position, $ReferenceRect.rect_size)


func _on_CameraRoom_area_entered(area):
	if not _CAM.main: return
	var r = $ReferenceRect.get_global_rect()
	_CAM.main.limit_top = r.position.y
	_CAM.main.limit_bottom = r.end.y
	_CAM.main.limit_left = r.position.x
	_CAM.main.limit_right = r.end.x
