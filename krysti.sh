#!/usr/bin/env bash
# Requires 'shuf' command
krysti_return_face() {
	if [ -z ${emo+x} ]; then
		emo="off"
	fi
	if [ "$emo" == "off" ]; then
		return 0
	fi
	happy="(✿◠‿◠)|ฅ(^•ﻌ•^)ฅ|(◠‿◠✿)|(❀❛ᴗ❛)"
	rawr="(◠△◠✿)|(⚆_⚆)|(︣ʘ‸︣ʘ✿)"
	wtf="(☞ﾟヮﾟ)|(ﾉ◕ヮ◕)ﾉ*:･"
	kill="(ノಠ益ಠ)ノ彡┻━┻|(づ｡◕‿‿◕｡)づ"
	case $@ in 
		0)
		#echo ${RAINBOW[@]}
		fret="happy"
		color="\\001\e[38;5;${RAINBOW[$((RANDOM % ${#RAINBOW[@]}))]}m\\002"
		;;
		1|2|126|127|128)
		fret="rawr"
		color="\\001\e[38;5;41m\\002"
		;;
		130|137)
		fret="kill"
		color="${BOLD}\\001\e[38;5;9m\\002"
		;;
		*)
		#echo "Debug others ${@}"
		fret="wtf"
		color="${BOLD}\\001\e[38;5;124m\\002"
		;;
	esac
	IFS='|', read -r -a faces <<< "${!fret}"
	shuf=$((RANDOM % ${#faces[@]}))
	echo -en "${color}${faces[$shuf]}${reset}"
}
krysti_rainbow() {
	n=0
	[[ "$@" == "$HOME"* ]] && { param="${@/$HOME/"~"}"; } || param=$@
	for ((i = 0; i < ${#param}; i++));	do
		echo -en "\001\e[38;5;${RAINBOW[$n]}m\002"
		echo -en "${param:$i:1}"
		[ $n -lt $((${#RAINBOW[@]}-1)) ] && { let "n=n+1"; } || n=0		
	done
}
show_colors() {
	for i in {1..255} ; do
		printf "\x1b[38;5;%sm%3d\e[0m " "$i" "$i"
		if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 15 == 0 )); then
			printf "\n";
		fi
	done
}
random_rainbow() {
	unset RAINBOW
	[[ $# -gt 0 ]] && { max=$1; } || max=10
	x=0
	for ((x = 0; x < ${max}; x++));	do
		rrand=`shuf -i 23-219 -n 1`
		RAINBOW[${x}]=${rrand}
		#echo -ne "\001\e[38;5;${RAINBOW[$x]}m\002"
		#echo -e "${x} ${RAINBOW[$x]}\001\e[0m\002"
	done
	DARKS=()
	LIGHTS=()
	for((d=0;d<10;d++)); do
		DARKS+=(`shuf -i 18-99 -n 1`)
		LIGHTS+=(`shuf -i 100-231 -n 1`)
	done
    BG=(${DARKS[$((RANDOM % ${#DARKS[@]}))]})
    FG=(${LIGHTS[$((RANDOM % ${#LIGHTS[@]}))]})
	#echo -e "${RAINBOW[@]} Max $max"
}
return_preset() {
	unset RAINBOW
	case $1 in
		kandi)
			RAINBOW=(129 135 99 141 171 177 207 213 134 140 128)
			BG=(55)
			FG=(199 200 201)
		;;
		mid)
			RAINBOW=(25 26 27 31 37 44 63 69 75 111 117 151)
			BG=(17)
			FG=(49 50 51)
		;;
		fire)
			RAINBOW=(124 160 198 208 209 210 214 215 216 190 226 227 228 245 246)
			BG=(52)
			FG=(229 230 231)
		;;
		lime)
			RAINBOW=(35 42 47 77 84 112 149 155 184 192)
			BG=(22)
			FG=(118 119 120)
		;;
		purples)
			RAINBOW=(93 129 165 171 201 207)
			BG=(54)
			FG=(199 200 201)
		;;
		reds)
			RAINBOW=(124 125 160 161 162 196 197 198)
			BG=(52)
			FG=(160 196)
		;;
		greens)
			RAINBOW=(34 40 41 46 47 48 118 119 120)
			BG=(22)
			FG=(82 83 84 113 114)
		;;
		yellows)
			RAINBOW=(148 149 150 154 155 156 190 191 192 193 194)
			BG=(144)
			FG=(226 227 228)
		;;
		oranges)
			RAINBOW=(172 173 174 202 203 204 208 209 210)
			BG=(94)
			FG=(202 203 204)
		;;
		blues)
			RAINBOW=(24 25 27 30 31 32 33 37 38 39 44 45 51 67 68 69 73 74 75 79 80 81 121 123 123)
			BG=(17  18  19)
			FG=(121 122 123)
		;;
		browns)
			RAINBOW=(58 94 95 96 100 101 102 130 131 132 136 137 138)
			BG=(94  95)
			FG=(223 224 225)
		;;
		*)
			RAINBOW=(129 135 99 141 171 177 207 213 134 140 128)
			BG=(55)
			FG=(199 200 201)
		;;
	esac
}
krysti_savedata() {
	echo "RAINBOW=(${RAINBOW[@]})" > ~/.krystish
	echo "LASTFG=\"${GITFG}\"" >> ~/.krystish
	echo "LASTBG=\"${GITBG}\"" >> ~/.krystish
	echo "LASTOK=\"${OKCOLOR}\"" >> ~/.krystish
	echo "ccolor=\"$ccolor\"" >> ~/.krystish
	echo "bcolor=\"$bcolor\"" >> ~/.krystish
	echo "dcolor=\"$dcolor\"" >> ~/.krystish
	echo "pcolor=\"$pcolor\"" >> ~/.krystish
	echo "emo=\"$emo\"" >> ~/.krystish
}
random_bits() {
	ccolor="\\001\e[38;5;${RAINBOW[$((RANDOM % ${#RAINBOW[@]}))]}m\\002" # Corner Color
	bcolor="\\001\e[38;5;${RAINBOW[$((RANDOM % ${#RAINBOW[@]}))]}m\\002" # Bracket Color
	dcolor="\\001\e[38;5;${RAINBOW[$((RANDOM % ${#RAINBOW[@]}))]}m\\002" # Dash Color
	pcolor="\\001\e[38;5;${RAINBOW[$((RANDOM % ${#RAINBOW[@]}))]}m\\002" # Prompt Color
    GITBG="\\001\e[48;5;${BG[$((RANDOM % ${#BG[@]}))]}m\\002"
    GITFG="\\001\e[38;5;${FG[$((RANDOM % ${#FG[@]}))]}m\\002"
    OKCOLOR="\\001\e[38;5;${RAINBOW[$((RANDOM % ${#RAINBOW[@]}))]}m\\002" # Github Branch OK
}
krysti_cwd_files() {
	shopt -s checkwinsize
	if [ $COLUMNS -lt 60 ]; then
		return 0
	fi
	fdir=$(find . -mindepth 1 -maxdepth 1 -type d -printf x  | wc -c)
	ffile=$(find . -mindepth 1 -maxdepth 1 -type f -printf x | wc -c)
	flink=$(find . -mindepth 1 -maxdepth 1 -type l -printf x | wc -c)
	#echo "${fdir} ${ffile} ${flink}"
	filestat=""
	if [ ! "$fdir" -eq "0" ]; then 
		filestat+=" ${fdir} "
	fi
	if [ ! "$ffile" -eq "0" ]; then 
		filestat+=" ${ffile} "
	fi
	if [ ! "$flink" -eq "0" ]; then 
		filestat+=" ${flink} "
	fi
	unset fdir ffile flink
	krysti_rainbow "$(krysti_is_remote) ${filestat}"
}
krysti_is_remote() {
	kcwd="$(pwd | sed "s;$HOME;~;")"
	if [[ "$kcwd" == "~" ]]; then
		echo -n " "
		return 0
	fi
	is_remote=$(mount | grep "_netdev" | awk '{print $3}' | sed "s;$HOME;~;")
	if grep -q "$is_remote" <<< "$kcwd" && [ ! -z "$is_remote" ]; then
		echo -n " "
	elif test -d "./.node_modules"; then
		echo -n " "
	else
		echo -n " "
	fi
}
krysti_prompt_cmd () {
	PEXIT=$?
	reset="\001\e[0m\002" 
	tcorner="${BOLD}${ccolor}┌${UNBOLD}"
	bcorner="${BOLD}${ccolor}└${UNBOLD}"
	dash="${dcolor}" 
	lbrak="${BOLD}${bcolor}[${UNBOLD}"
	rbrak="${BOLD}${bcolor}]${UNBOLD}"
	prmpt="${pcolor}\\$" 
	GITINVERSE="${GITBG/48/38}" # Inverse background color
    PS1="${tcorner}${lbrak}\$(krysti_rainbow \\u@\\h)${rbrak}" # user@host rainbow
    PS1+="${GITBG}${OKCOLOR}${BLACK}${reset}${dash} $(krysti_cwd_files)${dash}${GITBG}${BLACK}${OKCOLOR}" # CWD Directories/Folders/Links Count
    PS1+="\$(krysti_rainbow \\@)" # Time
    PS1+="\$(parse_git_branch)${reset}${GITINVERSE}${reset}\n" # GitHub
    PS1+="${bcorner}\$(krysti_return_face \$PEXIT)" # Emotional Prompt
    PS1+="${lbrak}\$(krysti_rainbow \\w)${rbrak}" # CWD path
    PS1+="${prmpt}${reset} " # Prompt
    export PS1
}
parse_git_branch ()
{
  color=""  
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    gwt=$(git rev-parse --is-inside-work-tree)
    if [[ "$gwt" != "false" ]]; then
    gcwd=`pwd`
    gitb="$(git branch 2>/dev/null | grep '^*' | awk '{print $2}')"
    gits=$(git status -s 2>&1 | wc -l)
    gitu=$( git ls-files --others --exclude-standard $(git rev-parse --show-cdup) | wc -l )
    fi
    if [[ "$gits" -gt 0 ]]; then
		#if [[ "${gcwd##*/}" != ".git" ]]; then
		gitb="${lbrak}(+${gits})${gitb}${rbrak}"
		#fi
    fi
    #echo $GITBG $GITFG
    gitver="${OKCOLOR}${GITFG}   $gitb${reset}"
  else
    return 0
  fi
  echo -e "$gitver"
}
if [[ "$0" != *"bash"* ]]; then
	printf '%s%s%s%s%s%s\n' "$(tput setaf 9)" "░▒▓ " "$(tput sgr0)" "This script must be run with the 'source' command."  "$(tput setaf 9) ▓▒░" "$(tput sgr0)"
fi
if [ -z ${COLUMNS+x} ]; then
	echo "No \$COLUMNS variable, setting now"
	shopt -s checkwinsize
fi
source_load() {
	if test -f "$HOME/.krystish"; then
		source $HOME/.krystish
	else
		emo=off
	fi
}
case $1 in 
	colors)
		show_colors
	;;
	setup|'set')
		unset PROMPT_COMMAND
		return_preset $2
		random_bits
		PROMPT_COMMAND=krysti_prompt_cmd
	;;
	random|ran|r)
		unset PROMPT_COMMAND
		random_rainbow $2
		random_bits
		PROMPT_COMMAND=krysti_prompt_cmd
	;;
	last|l|load)
		unset PROMPT_COMMAND
		source_load
		GITBG=$LASTBG
		GITFG=$LASTFG 
		OKCOLOR=$LASTOK
		PROMPT_COMMAND=krysti_prompt_cmd
	;;
	save|s)
		echo Saving Config
		krysti_savedata
	;;
	emo)
		emo=$2
		krysti_savedata
		source_load
	;;
	bashrc)
		echo "Added command to ~/.bashrc. Edit that if there is an issue"
		echo ". `pwd`/krysti.sh last" >> ~/.bashrc
	;;
	*)
		#source_load
		krysti_rainbow "Krysti.sh Help (Emotion: ${emo})"
		echo $(tput sgr0)
		#echo -e ${reset}
		
		echo "Parameters: (Required) [Optional]"
		echo ". ./krysti.sh colors"
		echo ". ./krysti.sh setup (kandi/mid/fire/lime/purples/reds/greens/browns/yellows/oranges/blues)"
		echo ". ./krysti.sh emo (on/off)"
		echo ". ./krysti.sh random [num]"
		echo ". ./krysti.sh last"
		echo ". ./krysti.sh save"
		echo ". ./krysti.sh bashrc"
	;;
esac
BOLD="\001\e[1m\002"
UNBOLD="\001\e[22m\002"
BLACK="\001\e[30m\002"
CYAN="\001\e[38;5;41m\002"
ICE="\001\e[38;5;123m\002"
BLUE="\001\e[38;5;63m\002"
SKYBLUE="\001\e[38;5;87m\002"
PINK="\001\e[38;5;213m\002"
HOTPINK="\001\e[38;5;201m\002"
DARKPURPLE="\001\e[38;5;56m\002"
BDARKPURPLE="\001\e[48;5;56m\002"
PURPLE="\001\e[38;5;93m\002"
BRED="\001\e[48;5;88m\002"
DARKRED="\001\e[38;5;88m\002"
RED="\001\e[38;5;124m\002"
YELLOW="\001\e[38;5;226m\002"
NEONAPPLE="\001\e[38;5;118m\002" 
GREEN="\001\e[38;5;42m\002" 
PWINK="\001\e[38;5;111m\002"
