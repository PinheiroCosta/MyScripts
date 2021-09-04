#!/usr/bin/env bash


catf() {
		# Search for a function by its name inside the script
		# Usage: catf function_name filename
		# Only works if the script is pre formated with the ending comment containing the function name.
		
		# Formatting
		RESET="\e[m";
		YELLOW="\e[33m";
		
		# parameters
		function=$1;
		filename=$2;
		
		# Error messages
		notFound="$function() not found in $filename.";
		usage="catf functionName filename.sh";
	
		if [ ! "$function" ] || [ ! "$filename" ]; then
		# if any parameter is missing show how to use the program with green text and exit
			printf "You should inform two arguments.\n"
			printf "$YELLOW\rusage: %s$RESET\n" "$usage";
		else
			found=false;
			ln=1;	# line number
			count=0;	# number of functions found
			while IFS= read -r line
			do
				if [[ "$line" == *"$function()"* ]]; then
				# If function name is inside the line...
					found=true;
					((count+=1));
				fi;

				if [ "$found" == true ]; then
				# if function is found...
					echo "$ln $line"; # prints the line with its number reference
					if [[ "$line" == *"}"* ]]; then
						#if the line contains a '}' character...
						found=false;
					fi;
				fi;
				# increment line number
				((ln+=1))

			done < "$filename";

			if [ "$count" -eq 0 ]; then
				# if no functions were found...
				echo "$notFound";
			fi;
		fi;
	
}		# --------------------------------- end of catf() function ------------------------------
