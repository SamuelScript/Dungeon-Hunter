extends Control

@onready var credits_panel: Panel = $CreditsPanel

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_credits_button_pressed() -> void:
	credits_panel.visible = true

func _on_back_button_pressed() -> void:
	credits_panel.visible = false

func _on_exit_button_pressed() -> void:
	get_tree().quit()
