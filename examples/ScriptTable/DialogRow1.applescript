tell application "ScriptTable"
	set t to the front document
	set r to the first row of t
	display dialog ((title of r) as string)
	--	quit
end tell