extends Resource
class_name QuestionsQuiz

# Define the enum inside the class
enum QuestionType { TEXT, IMAGE, AUDIO }


@export var question_info : String 
@export var questioninfo2 : String 
@export var type : QuestionType
@export var muñequito: Texture2D
@export var imagen: Texture2D
@export var options: Array[String]
@export var options2 : Array [String]
@export var correct: String
