# function fish_prompt -d "Write out the prompt"
  # set -l directory (set_color $fish_color_cwd) (prompt_pwd)
  # set -l branch (set_color magenta) (fish_vcs_prompt | sed "s/ (\(.*\))/\1/")
  # set -l prompt (set_color $fish_color_end) "&"
  # echo -nse $directory "\n"
  # echo -nse $branch " " $prompt " " (set_color normal)
  # printf '%s%s \n%s & %s' (set_color $fish_color_cwd) (prompt_pwd) (echo $branch) (set_color normal)
# end

set charPrompt "&"
set charArrowPass "‣"
set charArrowFail "×"
set charArrowTerm "■"

set charGitBehind "◒"
set charGitAhead "◓"
set charGitBoth "●"

set customRed    (set_color ff6c6b)
set customOrange (set_color f2c68a)
set customYellow (set_color cae682)
set customGreen  (set_color 95e454)
set customBlue   (set_color 87afff)
set customPurple (set_color B7D)
set customCopper (set_color FFAA22)
set customMuted  (set_color aaa)
set customTime   (set_color 73797e)

function fish_prompt
	set error $status
	set charUser "&"

	set colorTime   $customOrange
	set colorPath   $customBlue
	set -g colorArrow  $customGreen
	set colorChar   $customCopper
	set colorError  $customRed
	set colorBranch	$customPurple
	set charArrow   $charArrowPass

	# set_git_changes

	if test $error -eq 130
		set error
		set colorArrow $customRed
		set charArrow $charArrowTerm
	else if test $error -ne 0
		set error $error\ ;
		set colorArrow $colorError
		if test $error -ne 130
			set charArrow $charArrowFail
		end
	# else if test -n "$branch"
		# set error
		# set changes $git_changes
		# if test -n "$changes"
			# set changes (string split \  $changes)
			# set colorArrow $customBlue
			# if test $changes[1] -ne 0 -a $changes[2] -ne 0
				# set charArrow $charGitBoth
			# else if test $changes[1] -ne 0
				# set charArrow $charGitAhead
			# else
				# set charArrow $charGitBehind
			# end
		# end
	else
		set error
	end

	set charArrow "$charArrow "

	sudo -n true 2> /dev/null;
	if test $status -eq 0
		set charUser "#"
		set colorChar $customRed
	end

  set -l indent " "
	if test -n "$VIM"
		set indent ""
	end
	echo -nse "\a" \
    $colorArrow $indent ┌ " " \
		(get_cmd_timer) \
		$colorTime (date "+%H:%M") " " \
		$colorPath (get_prompt_pwd)\
		\n \
		$colorArrow $indent └ $charArrow \
    (set_color magenta) (fish_vcs_prompt | sed "s/ (\(.*\))/\1/")\ \
		$colorBranch $branch\ \
		$colorError $error \
		$colorChar $charUser\ \
		(set_color normal);
end

function get_cmd_timer
	if test $CMD_DURATION -gt 9
		echo -n -s $customTime $CMD_DURATION "ms "
	end
end

function get_prompt_pwd
	set -l start (string sub -e 26 (pwd))
	if test $start = "/home/coop/ghq/github.com/"
		echo -n -s " " (string sub -s 27 (pwd)) # 
	else
		echo -n -s (prompt_pwd)
	end
end
