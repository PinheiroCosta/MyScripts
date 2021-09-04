#!/usr/bin/env bash


catf() {
		# Search for a function inside the input script by its name
		# Usage: catf function_name filename
		# Only works if the script is pre formated with the ending comment containing the function name.
		
		# Formatting
		RESET="\e[m";
		GREEN="\e[32m";
		YELLOW="\e[33m";
		
		# parameters
		function=$1;
		filename=$2;
		
		# Error messages
		notFound="$function not found in $filename.";
		usage="catf functionName filename.sh";
	
		# if any parameter is missing show how to use the program in green and exit
		if [ ! "$function" ] || [ ! "$filename" ]; then
			printf "You should inform two arguments.\n"
			printf "$YELLOW\rusage: %s$RESET\n" "$usage";
		else
			# get the starting line of the function
			startLine=$(grep -nsm 1 "$function \?() \?{" "$filename" | \
				cut -d ':' -f 1);
			
			# if command runs successfuly
			if [ "$startLine" ]; then
					# get the ending line of the function
					endingLine=$(sed -n "$startLine,$ p" "$filename" | \
						grep -nsm 1 "}[[:space:]]" | \
						cut -d ':' -f 1);
					# if found the complete body of the  function
					if [ "$endingLine" ]; then
							# echo the body of the function	
							functionText=$(head -"$((startLine + endingLine))" "$filename" | \
								tail -"$((endingLine + 1))");
							echo -e "$functionText";
					else
						echo "function $function() was found in the document, but it couldn't be retrieved."
					fi;
			else
					echo "$notFound"
		fi;
	

		fi

}		# --------------------------------- end of catf() function ------------------------------
