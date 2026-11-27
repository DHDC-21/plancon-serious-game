extends Node



# VARIÁVEIS DE ESTADO
var index_atual: int = 0
var fases: Array[QuestionModel] = []

var qtde_maxima_fases: int = 0
var qtde_fases_a_responder: int = 0

var acertos: int = 0



func _ready() -> void:
	pass



func _process(_delta: float) -> void:
	pass



func start_game(lista_de_fases: Array[QuestionModel], qtde_fases: int) -> void:
	if lista_de_fases.is_empty():
		push_error("Não é possível iniciar o jogo sem fases.")
		return

	print("Iniciando o jogo com ", qtde_fases_a_responder, " fases.")

	qtde_maxima_fases = lista_de_fases.size()
	qtde_fases_a_responder = clampi(qtde_fases, 1, qtde_maxima_fases)

	fases = lista_de_fases.duplicate()
	fases.shuffle()
	fases.resize(qtde_fases_a_responder)
	index_atual = 0

	carregar_pergunta_atual()



func carregar_pergunta_atual() -> void:
	print("Carregando pergunta atual: ", index_atual)

	var pergunta_atual = fases[index_atual]
	var caminho_da_engine: String = ""

	if pergunta_atual is MultiplaEscolhaModel:
		caminho_da_engine = "res://src/engines/multipla_escolha/multipla_escolha.tscn"

	elif pergunta_atual is SelecaoMultiplaModel:
		caminho_da_engine = "res://src/engines/selecao_multipla/selecao_multipla.tscn"


	elif pergunta_atual is VerdadeiroOuFalsoModel:
		caminho_da_engine = "res://src/engines/verdadeiro_ou_falso/verdadeiro_ou_falso.tscn"

	else:
		print("Erro: Tipo de pergunta não suportado: ", pergunta_atual)
		return

	print("Carregando engine: ", caminho_da_engine)
	get_tree().change_scene_to_file(caminho_da_engine)



func carregar_proxima_pergunta() -> void:
	index_atual += 1

	if index_atual < fases.size():
		carregar_pergunta_atual()
	else:
		print("Fim do jogo! Todas as perguntas foram respondidas.")
		get_tree().change_scene_to_file("res://src/ui/placar/placar.tscn")
