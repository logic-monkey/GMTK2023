tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("_CAM", "res://addons/2d_cam/camera_controls.gd")


func _exit_tree():
	remove_autoload_singleton("_CAM")
