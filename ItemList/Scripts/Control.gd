extends Control

signal firstCheck
signal secondCheck
signal thirdCheck


func _on_ItemList_item_activated(index):
	if index == 0:
		print(index)
		emit_signal("firstCheck")
		$ItemListLevels.visible = false
	if index == 1:
		print(index)
		emit_signal("secondCheck")
		$ItemListLevels.visible = false
	if index == 2:
		print(index)
		emit_signal("thirdCheck")
		$ItemListLevels.visible = false

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")
	$Button.visible = false
