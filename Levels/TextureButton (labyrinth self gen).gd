extends TextureButton
#Selfgen button

func _ready():
	var button = Button.new()
	button.text = " Self generating Labyrinth"
	button.pressed.connect(self._button_pressed)
	add_child(button)

#var simultaneous_scene = preload().instantiate() # annat sätt o göra
func _button_pressed():
	print("Labyrith button pressed")
	#get_tree().root.add_child(simultaneous_scene)	#annat sätt o göra
	#get_tree().change_scene_to_file("res://Levels/labyrinth_level.tscn")
	get_tree().change_scene_to_file("res://Levels/self_generating_labyrinth.tscn")
