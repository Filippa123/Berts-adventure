extends Area2D

var simultaneous_scene = preload("res://you_won_menu.tscn").instantiate()

func _on_body_entered(body):
	print("WIN :D") # Replace with function body.
#adda vid behov en if som kollar att de e bert o int vad som helst
	if body.is_in_group("Player"):
		print("Win :D (bert)")
		#get_tree().change_scene_to_file("res://Levels/win_screen.tscn")
		get_tree().root.add_child(simultaneous_scene)

