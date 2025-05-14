portstable() {
    local regex_pattern="([0-9]+)/([a-z]+)/([a-z]+)//([a-z-]*)///"

    local str=`echo $1 | tr -s ',' '\n'`
    echo "| PORT | STATE | SERVICE |"
    echo "| --- | --- | --- |"

    while read -r line; do
        if [[ $line =~ $regex_pattern ]]; then
            local service=${match[4]}
            if [[ $service == "http" || $service == "https" ]]; then
                service="[${service}](#Web)"
            else
                service="[[#${service}]]"
            fi
            echo "| ${match[1]}/${match[2]} | ${match[3]} | $service |"
        fi
    done <<< "$str"
}

routestable() {
    local regex_pattern="\/([a-zA-Z]+)\s+\(Status: ([0-9]+)\) \[Size: ([0-9]+)\]"
    local transformed_input=""
    echo "| ROUTE | STATUS | SIZE |"
    echo "| --- | --- | --- |"

    while IFS= read -r line; do
        line=$(echo "$line" | sed -E 's/\x1B\[[0-9;]*[mGK]//g')
        if [[ $line =~ $regex_pattern ]]; then
            local route="/${match[1]}"
            local status_code="${match[2]}"
            local size="${match[3]}"
            local color=""
            case $status_code in
                2[0-9][0-9])
                    color="green"
                    ;;
                3[0-9][0-9])
                    color="cyan"
                    ;;
                4[0-9][0-9])
                    color="orange"
                    ;;
                5[0-9][0-9])
                    color="red"
                    ;;
                *)
                    color="purple"
                    ;;
            esac
            transformed_input+="| ${route} | <span style=\"color:${color}\">**${status_code}**</span> | ${size} |\n"
        fi
    done < $1

    echo "$transformed_input"
}

