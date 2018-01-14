use_emoticons=false
bold="\[$(tput bold)\]"
reset="\[$(tput sgr0)\]"
blue="\[$(tput setaf 6)\]"
darkblue="\[$(tput setaf 4)\]"
green="\[$(tput setaf 2)\]"
yellow="\[$(tput setaf 3)\]"
doublewidth="\[$(tput sc)\] \[$(tput rc)\]"
if [ $UID -gt 0 ]; then
  promptchar='$'
else
  promptchar='#'
fi
if [ "$TERMINAL" = 'linux' ] || [ $use_emoticons != 'true' ]; then
  branchchar='#'
  userchar=''
  hostchar='@'
  dirchar=':'
else
  userchar="${doublewidth}👤"
  branchchar=" ${doublewidth}🌱"
  hostchar=" ${doublewidth}💻"
  dirchar=" ${doublewidth}📂"
fi
function calculate_prompt() {
  gitbranch=$(git symbolic-ref -q --short HEAD 2> /dev/null)
  if [ $? -gt 0 ]; then
    unset gitbranch
  else
    gitbranch="${reset}${branchchar}${bold}${darkblue}${gitbranch}"
  fi
  export PS1="${userchar}${bold}${blue}\u${reset}${hostchar}${bold}${green}\h${reset}${dirchar}${bold}${yellow}\w${gitbranch}${reset}${bold}${promptchar}${reset} "
}
export PROMPT_COMMAND=calculate_prompt
