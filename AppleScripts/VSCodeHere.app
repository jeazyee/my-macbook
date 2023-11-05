(* 
    Open VS Code Here 
     
    A toolbar script for Mac OS X 10.3+
     
    Written by Brian Schlining for opening iTerm
    Modified by Jitendra Bodmann for opening VS Code here
*)


property debug : false


on run
	tell application "Finder"
		try
			set this_folder to (the target of the front window) as alias
		on error
			-- get the alias of the home folder of the current user
			set this_folder to path to home folder
		end try
		
		my process_item(this_folder)
		
	end tell
end run


on open these_items
	repeat with i from 1 to the count of these_items
		set this_item to item i of these_items
		my process_item(this_item)
	end repeat
end open


on process_item(this_item)
	
	set thePath to POSIX path of this_item
	do shell script "/usr/local/bin/code " & quote & thePath & quote
	
end process_item
