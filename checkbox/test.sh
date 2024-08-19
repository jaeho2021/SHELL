#!/bin/bash

# customize with your own.
options=("AAA" "BBB" "CCC" "DDD" "EEE" "FFF" "GGG" "HHH" "III" "JJJ" "KKK" "LLL" "MMM" "NNN" "OOO" "PPP" "QQQ" "RRR" "SSS" "TTT" "UUU" "VVV" "WWW" "XXX" "YYY" "ZZZ" "AAA1" "BBB2" "CCC1" "DDD1" "EEE1" "FFF1" "GGG1" "HHH1" "III1" "JJJ1" "KKK1" "LLL1" "M1MM" "1NNN" "O1OO" "P1PP" "Q1QQ" "1RRR" "S1SS" "1TTT" "U1UU" "1VVV" "1WWW" "XX1X" "Y1YY" "1ZZZ")


menu() {
    echo "Avaliable options:"
    for i in ${!options[@]}; do
        if [[ "${choices[i]}" == "*" ]]; then
		printf "\e[0;92m%3d%s) %s\e[0m\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
	else
        	printf "%3d%s) %s\n" $((i+1)) " " "${options[i]}"
	fi
    done
    if [[ "$msg" ]]; then echo "$msg"; fi
}

prompt="Check an option (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" input && [[ "$input" ]]; do
    IFS=' ' read -r -a nums <<< "$input"
    for num in "${nums[@]}"; do
        [[ "$num" != *[![:digit:]]* ]] &&
        (( num > 0 && num <= ${#options[@]} )) ||
        { msg="Invalid option: $num"; continue; }
        ((num--));
        msg="${options[num]} was ${choices[num]:+un}checked"
        [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="*"
    done
done

printf "You selected"; msg=" nothing"
for i in ${!options[@]}; do 
    [[ "${choices[i]}" ]] && { printf " %s" "${options[i]}"; msg=""; }
done
echo "$msg"
