extends QuestionEngineBase


@onready var botao_verdadeiro: Button = %BotaoVerdadeiro
@onready var botao_falso: Button = %BotaoFalso

var resposta_selecionada: bool	# Seleciona se a resposta é verdadeiro ou falso

@export_category("Teste")
# Existe uma variavel pergunta que armazena a pergunta atual
@export var teste: VerdadeiroOuFalsoModel


func _on_ready() -> void:
	if teste:
		pergunta = teste

	botao_verdadeiro.pressed.connect(
		func() -> void:
			resposta_selecionada = true
	)

	botao_falso.pressed.connect(
		func() -> void:
			resposta_selecionada = false
	)

func _checar_resposta() -> bool:
	if resposta_selecionada == pergunta.resposta_correta:
		return true
	else:
		return false
