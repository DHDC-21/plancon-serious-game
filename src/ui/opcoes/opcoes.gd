extends Control



@onready var campo_quantidade: SpinBox = %CampoQuantidade



func _ready() -> void:
	var limite := GameController.qtde_maxima_fases
	campo_quantidade.min_value = 1
	campo_quantidade.max_value = maxi(limite, 1)
	campo_quantidade.step = 1
	campo_quantidade.editable = limite > 0

	if limite > 0:
		campo_quantidade.value = clampi(
			GameController.qtde_fases_a_responder, 1, limite
		)
	else:
		campo_quantidade.value = 1

	campo_quantidade.value_changed.connect(_on_campo_quantidade_value_changed)



func _on_campo_quantidade_value_changed(valor: float) -> void:
	if GameController.qtde_maxima_fases <= 0:
		return

	GameController.qtde_fases_a_responder = clampi(
		int(valor), 1, GameController.qtde_maxima_fases
	)

	print("Quantidade de fases a responder atualizada para: ", GameController.qtde_fases_a_responder)



func _on_btn_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://src/ui/menu/main_menu.tscn")
