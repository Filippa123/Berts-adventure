extends Control

func next_level():
	print("next clicked")
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	var next_level_path = "res://Levels/labyrinth_level_" + str(next_level_number) +".tscn"
	get_tree().change_scene_to_file(next_level_path)
	
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
