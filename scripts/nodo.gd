extends Node
class_name Nodo

var escena: Escenas
@export var pregunta: String
@export var opciones: Array[String]=[]
@export var correcta: String
var left: Nodo 
var right: Nodo 

func _init( escena_: Escenas, pregunta_: String, opciones_:Array[String], correcta_: String):
		escena= escena_
		pregunta=pregunta_
		opciones=opciones_
		correcta= correcta_
		left=null
		right=null
