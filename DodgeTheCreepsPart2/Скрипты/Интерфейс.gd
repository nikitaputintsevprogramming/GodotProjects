extends CanvasLayer

# Сигнал для исчезновения надписей и кнопки
signal start_game

func update_score(score):
	$Score.text = str(score)

func _on_Button_pressed():
	$Score.hide()
	$Message.hide()
	emit_signal("start_game")
