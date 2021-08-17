#!/usr/bin/env bash

catf() {
    # Search for a function inside the document
    # Usage: catf function_name filename
    # insert the name of the function without the parenthesis 
    # ex: catf instead of catf().

    function=$1;
    filename=$2;
    error="$function not found in $filename."

    # get the starting line of the function
    startLine=$(grep -nm 1 "$function \?() \?{" "$filename" | \
    cut -d ':' -f 1);

    # if command runs successfuly
    if [ "$startLine" ]; then
        # get the ending line of the function
        endingLine=$(sed -n "$startLine,$ p" "$filename" | \
        grep -nm 1 "}[[:space:]]" | \
        cut -d ':' -f 1);
        # if found the complete body of the  function
        if [ "$endingLine" ]; then
            # echo the body of the function	
            functionText=$(head -"$((startLine + endingLine))" "$filename" | \
            tail -"$((endingLine + 1))");
            echo "$functionText";
        else
            echo "$error"
        fi;
    else
        echo "$error"
    fi;
}   # --------------------------------- end of catf() function ------------------------------
