extends Node
class_name ArbolBinario

@export var nodo_llegada: Nodo
@export var raiz: Nodo
@export var quiz: QuizTheme  # Referencia al recurso QuizTheme
var altura_max: int = 4# Límite mínimo de altura
@export var escenasNivel :Array[Escenas]= []
var nodos: Array[Nodo] = []# Lista que almacenará todos los nodos creados



func escenaAleatoria():
	escenasNivel.clear()
	var usados = []
	for i in range(altura_max):
		var indice = quiz.escenas[randi() % quiz.escenas.size()]
		while indice in usados:
			indice = quiz.escenas[randi() % quiz.escenas.size()]
		usados.append(indice)
		var escena_aleatoria = quiz.escenas[indice]
		escenasNivel.append(escena_aleatoria)

func construir_arbol_perfecto():
	nodos.clear()  
	escenaAleatoria()
	raiz = llenarArbol(null,0)  

func llenarArbol(nodo: Nodo, nivel: int) -> Nodo:	
	if nivel >= altura_max:
		return null
					
	if nodo == null:
		var escena = escenasNivel[nivel]
		var a= quiz.theme[randi()% quiz.theme.size()]
		var pregunta_aleatoria = a.question_info
		var opciones= a.options
		var correcta= a.correct
		nodo = Nodo.new(escena, pregunta_aleatoria, opciones, correcta)  # Crear el nuevo nodo
		nodos.append(nodo)  # Añadirlo a la lista de nodos
	# Llenar los subárboles izquierdo y derecho
	nodo.left = llenarArbol(nodo.left, nivel + 1)
	nodo.right = llenarArbol(nodo.right, nivel + 1)	

	return nodo  

		
	
		
func imprimir_arbol_preorden(nodo: Nodo, nivel: int = 0) -> void:
	if nodo == null:
		print("Nivel ", nivel, ": Nodo vacío")
		return

	print("Nivel ", nivel, ": ", nodo.pregunta)

	imprimir_arbol_preorden(nodo.left, nivel + 1)
	imprimir_arbol_preorden(nodo.right, nivel + 1)
	
func obtenerPregunta(nodo:Nodo):
	if nodo!=null:
		mostrarPregunta(nodo.pregunta,nodo.opciones)
func mostrarPregunta(pregunta: String, opciones: Array[String]):
	print("Pregunta: ",pregunta)
	for opcion in opciones:
		print("Opcion: ", opcion)
		
func _ready()->void:
	#escenasNivel= quiz.escenas
	raiz = llenarArbol(null, 0)  # Aquí llenamos el árbol desde un nodo raíz nulo
	if raiz != null:
		imprimir_arbol_preorden(raiz)
	# Seleccionar un nodo de llegada aleatorio (diferente de la raíz)
		nodo_llegada = nodos[randi() % nodos.size()]  
	# Asegurarse de que el nodo de llegada no sea la raíz
		if nodo_llegada == raiz:
			nodo_llegada = nodos[(randi() % (nodos.size() - 1)) + 1] 
			print("Nodo de llegada: ", nodo_llegada.pregunta)
	else:
		print("El árbol no se ha creado correctamente.")
