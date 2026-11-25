extends Control



@onready var qtd_perguntas = GameController.fases.size()
@onready var acertos = GameController.acertos
@onready var carregar_acertos = %Acertos.get_node("CampoDinamico")


func _ready() -> void:
	carregar_acertos.text = "[" + str(acertos) + " / " + str(qtd_perguntas) + "]"



func _process(delta: float) -> void:
	pass



func _on_btn_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://src/ui/menu/main_menu.tscn")
