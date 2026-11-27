extends Control



@onready var popup_sair = %PopupSair
@export var fases: Array[QuestionModel] = []
@export var qtde_fases_a_responder: int = 3


func _ready() -> void:
	GameController.qtde_maxima_fases = fases.size()
	if GameController.qtde_maxima_fases > 0:
		if GameController.qtde_fases_a_responder <= 0:
			GameController.qtde_fases_a_responder = qtde_fases_a_responder
		GameController.qtde_fases_a_responder = clampi(
			GameController.qtde_fases_a_responder, 1, GameController.qtde_maxima_fases
		)

	if popup_sair != null:
		popup_sair.confirmed.connect(_on_popup_sair_confirmed)
		popup_sair.canceled.connect(_on_popup_sair_cancelled)

	%Music.play()



func _on_audio_stream_player_finished() -> void:
	%Music.play()  # Reinicia a música quando terminar



func _on_btn_iniciar_pressed() -> void:
	print("Botão iniciar pressionado! Carregando as fases no GameController...")
	GameController.start_game(fases, GameController.qtde_fases_a_responder)



func _on_btn_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://src/ui/creditos/creditos.tscn")



func _on_btn_opcoes_pressed() -> void:
	get_tree().change_scene_to_file("res://src/ui/opcoes/opcoes.tscn")



func _on_btn_sair_pressed() -> void:
	# Abre o popup de confirmação para sair.
	if popup_sair != null:
		popup_sair.dialog_text = "Você tem certeza que deseja fechar o jogo?"
		popup_sair.popup_centered()



func _on_popup_sair_confirmed() -> void:
	get_tree().quit()



func _on_popup_sair_cancelled() -> void:
	if popup_sair != null:
		popup_sair.hide()
