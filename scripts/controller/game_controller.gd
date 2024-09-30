extends Node

@export var quiz: QuizTheme 
@export var color_right: Color
@export var color_wrong: Color

var icon_1: Texture2D 
var icon_2: Texture2D
var index_recorrido: int=0
var botones_recorrer: Array[Button]=[]
var nodo_recorrer: Nodo
var boton_recorrer: Button
var boton_aux: Button
var botones: Array[Button]
var aquiEstaNodo: Nodo
var aquiEstaBoton: Button
var buttons: Array[Button] = []
var index: int = 0
var correct: int
var incorrect: int
var aux: Nodo
var arbol: ArbolBinario 
var current_quiz: QuestionsQuiz:
	get: return quiz.theme[index]

@onready var texto_pregunta = $Control/NinePatchRect/PreguntaInfo/Panel/PreguntaTexto
@onready var audio_pregunta = $Control/NinePatchRect/PreguntaInfo/Panel/PreguntaAudio
@onready var imagen_pregunta = $Control/NinePatchRect/PreguntaInfo/Panel/PreguntaImagen
#@onready var muñequito = $GeneralPanel/Generalvbox/ContenidoPreguntas/ContentHolder/muñequito #Donde se encuentra muñequito
@onready var soundtrack = $SoundTrack 


func _ready() -> void:
	#$Soundtrack.play()
	
	icon_1= preload("res://imagenes/spritenuevo.png")
	icon_2= preload("res://imagenes/spriiteFinal.png")
	$Control/NinePatchRect2.hide()
	$Control/NinePatchRect3.hide()
	$Control/Volver.hide()
	arbol=$CanvasLayer
	#arbol.llenarArbol(arbol.raiz,0)
	#arbol.construir_arbol_perfecto()
	#correct =0
	aquiEsta(arbol.raiz)
	#recorrer(arbol.raiz)

	randomize_array(quiz.theme) # Add this line to shuffle the questions
	# Collect buttons from AnswerHolder
	for child in $Control/NinePatchRect/PreguntaOpciones.get_children():
		if child is Button:
			buttons.append(child)
			#print("Button added from AnswerHolder:", child.name)
	
	load_quiz(arbol.raiz)


func load_quiz(nodo: Nodo) -> void:
		#if index >= quiz.theme.size():
		if nodo == arbol.nodo_llegada:
			get_tree().change_scene_to_file("res://final.tscn")
			return
		aux=nodo
		
		var options = nodo.opciones
		texto_pregunta.text = nodo.pregunta
		print("Pregunta: ",nodo.pregunta)
		for option in nodo.opciones:
			print("Opcion ",option)
		
	
		for i in buttons.size():
			buttons[i].text = options[i]
			buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))

		#match current_quiz.type:
			#Enum.QuestionType.TEXT:
				#$Control/NinePatchRect/PreguntaInfo/Panel.hide()
				#muñequito.texture= current_quiz.muñequito
				#muñequito.show()
			#Enum.QuestionType.IMAGE:
				#imagen_pregunta.texture= quiz.theme[index].imagen
				#$Control/PreguntaInfo/Panel.show()
func _buttons_answer (button) -> void:

	if aux.correcta == button.text:
		button.modulate = color_right
		correct +=1		
		$AudioCorrect.play()	
		$Control/NinePatchRect2.show()
		$Control/NinePatchRect.hide()
	else:
		button.modulate = color_wrong
		incorrect +=1
		$AudioIncorrect.play()
		var a= quiz.theme[randi()% quiz.theme.size()]
		aux.pregunta= a.question_info
		aux.opciones= a.options
		aux.correcta=a.correct
		_nextQuestion()
		load_quiz(aux)
	
	#_nextQuestion()	

func _nextQuestion ():

	for bt in buttons:
		bt.pressed.disconnect(_buttons_answer)
	
	
	await get_tree().create_timer(0.45).timeout
	
	for bt in buttons:
		bt.modulate = Color("#ffffff")
		#muñequito.hide()
		
	audio_pregunta.stop()
	#audio_pregunta.stream = null
	

	
	
func randomize_array(array:Array) -> Array:
	var array_temp=array
	array.shuffle()
	return array_temp


func _on_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://opciones.tscn")


func _on_salir_pressed() -> void:
	get_tree().change_scene_to_file("res://ui.tscn")


func _on_izquierda_pressed() -> void:
	if aquiEstaNodo.left==null && aquiEstaNodo.right==null:
		get_tree().change_scene_to_file("res://finalMalo.tscn")
		return
	_nextQuestion()
	botones.clear()
	$Control/NinePatchRect2.hide()
	for children in aquiEstaBoton.get_children():
		if children is HBoxContainer:
			for child in children.get_children():
				if child is Button:
					botones.append(child)
	$Control/NinePatchRect.show()
	aquiEstaRecursivo(aux.left, botones[0])
	load_quiz(aux.left)
	


func _on_derecha_pressed() -> void:
	if aquiEstaNodo.left==null && aquiEstaNodo.right==null:
		get_tree().change_scene_to_file("res://finalMalo.tscn")
		return
	_nextQuestion()
	botones.clear()
	$Control/NinePatchRect2.hide()
	for children in aquiEstaBoton.get_children():
		if children is HBoxContainer:
			for child in children.get_children():
				if child is Button:
					botones.append(child)
	$Control/NinePatchRect.show()
	
	aquiEstaRecursivo(aux.right, botones[1])
	load_quiz(aux.right)

func aquiEsta(nodo: Nodo):
	if nodo==arbol.raiz:
		aquiEstaNodo= nodo
		aquiEstaBoton= $Control/NinePatchRect3/HBoxContainer/Button
		aquiEstaBoton.icon= icon_2
		boton_aux= aquiEstaBoton
	  
func aquiEstaRecursivo(nodo: Nodo, boton: Button):
	aquiEstaNodo= nodo 
	aquiEstaBoton= boton
	aquiEstaBoton.icon= icon_2
	if boton_aux != aquiEstaBoton:
		boton_aux.icon= icon_1
		boton_aux=aquiEstaBoton

func _on_volver_pressed() -> void:
	$Control/NinePatchRect3.hide()
	$Control/Volver.hide()
	$Control/NinePatchRect.show()


func _on_mapa_pressed() -> void:
	$Control/NinePatchRect.hide()
	$Control/NinePatchRect3.show()
	$Control/Volver.show()
