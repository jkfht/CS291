extends Node
#Data object for vertices.
@export var Incidents: Array #Stores an array of incident edges and the adjacent vertex on that edge.
@export var Name: String
@export var Dot: Sprite2D #Hold the vertex's associated map dot.
@export var Coords: Vector2i #Position of the vertex on the map.

func init(NameParam:String,CoordsParam:Vector2i = Vector2i(0,0),DotParam:Sprite2D=null):
	Name = NameParam
	Coords = CoordsParam
	Dot = DotParam
	if Dot != null:
		Dot.position = Coords
		Dot.modulate = Color(1,1,0)
