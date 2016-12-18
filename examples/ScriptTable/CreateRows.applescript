tell application "ScriptTable"
	tell the front document
		clear rows
		add row displaying "wibble"
		add row displaying "fish"
		add row displaying "banana"
		add row displaying "aubergine"
	end tell
end tell