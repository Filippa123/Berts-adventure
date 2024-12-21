extends Control

func next_level():
	print("next clicked")
	
func menu():
	print("menu clicked")
	get_tree().change_scene_to_file("res://Levels/start_level.tscn")

func pause():
	get_tree().paused = true

func testWin():
	pass

func _on_next_level_pressed():
	next_level()


func _on_menu_pressed():
	menu()
