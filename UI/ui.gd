extends VBoxContainer

#Contains the UI child elements in the display.
#Script only needed to pass the signal from the Selector child elements to the main program
signal Recalculate_Path
func Selector_Changed(index: int): #Passes signal from Selectors to main program
	Recalculate_Path.emit()
