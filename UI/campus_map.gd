extends Sprite2D
#Visual display of the campus map. 

@export var Lines: Array = [] #Array of bold lines on the nap.
@export var Labels: Array = [] #Array of all labels. Intended to be used to hide labels. Currently unused.

#Create a dot on the map to represent a vertex
func New_Dot() -> Sprite2D:
	var dot = Sprite2D.new()
	dot.texture = load("res://imgs/vertex.png")
	self.add_child(dot)
	return dot
#Create a label on the map, displaying text in the Name parameter
func New_Label(Name:String):
	var lab = Label.new()
	lab.text = Name
	lab.set("theme_override_colors/font_color",Color(0,0,0))
	add_child(lab)
	Labels.append(lab)
	return lab

#Add a static line and label on the map representing an edge and the weight
func Add_Ghost_Edge(Vert1: Vector2, Vert2: Vector2, Weight: float):
	var line = Line2D.new()
	line.default_color = Color(0.5,0.5,0.5)
	line.width = 2
	line.add_point(Vert1)
	line.add_point(Vert2)
	add_child(line)
	var lab = Label.new()
	lab.text = str(Weight)
	lab.set("theme_override_colors/font_color",Color(0,0,0))
	line.add_child(lab)
	lab.position = (Vert1+Vert2) / 2
	pass

#Create a bold line along the path provided
func Add_Line(Path: Array):
	var line = Line2D.new()
	line.default_color = Color(0,0,0)
	line.width = 5
	for point in Path:
		line.add_point(point)
	add_child(line)
	Lines.append(line)
#Erases all bold lines
func Clear_Lines():
	for line in Lines:
		remove_child(line)

func Load_Map_Image():
	
	var map:Image 
	if OS.has_feature("standalone"):
		map = Image.load_from_file(OS.get_executable_path().get_base_dir()+"/map.png")
	else:
		map = Image.load_from_file("res://map.png")
	var map_texture = ImageTexture.create_from_image(map)
	texture = map_texture
