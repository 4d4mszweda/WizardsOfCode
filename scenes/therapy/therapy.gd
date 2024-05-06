extends Control


func _on_button_pressed():
	Events.therapy_exited.emit()
