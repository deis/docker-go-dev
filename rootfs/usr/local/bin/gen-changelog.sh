#!/usr/bin/env bash
#
# Prints a Markdown-formatted summary of git commits ready to include in
# a CHANGELOG.md file
#
# Usage: gen-changelog.sh [from] [to]
# If no [from] argument is supplied, uses the most recent git tag.
# if no [to] argument is supplied, uses git HEAD.
#
# The REPOROOT and TYPES variables may be used to customize what links are
# generated and what is scraped from the commit logs.

set -euo pipefail

PACKAGE=${PACKAGE:=$(go list .)}
REPOROOT=${REPOROOT:=https://$PACKAGE}
TYPES=${TYPES:=feat(;Features fix(;Fixes docs(;Documentation chore(;Maintenance}

# Print the information scraped from git
retrieve() {
    while read -r commit hash message; do
        # Extract the subsystem where type(subsystem): message
        SUBSYSTEM=$(echo "$message" | cut -d'(' -f2 | cut -d')' -f1 | sed 's/\*/\(all\)/g')
        # Extract the message where type(subsystem): message
        MESSAGE=$(echo "$message" | awk -F ")" '{ print $2}' | sed 's/://' | cut -f2- -d' ')
        # Generate a link to the full legal commit on GitHub
        LINK="$REPOROOT/commit/$hash"
        # Echo all this in a way that makes the commit hash and message a link
        # to the commit in markdown
        echo ' -' "[\`$commit\`]($LINK)" "$SUBSYSTEM": "$MESSAGE"
    done < <(git --no-pager log --oneline --merges --oneline --format="%h %H %b" --grep="$1" "$FROM".."$TO")
    # Scrape the information from git
}

# Wrap feature type and show its relevant commits
subheading() {
    echo "#### $1"
    echo
    retrieve "$2"
    echo
}

main() {
    FROM=${1:-$(git describe --abbrev=0 --tags)}
    TO=${2:-"HEAD"}
    RELEASE=${RELEASE:=$TO}

    printf "### %s -> %s\n\n" "$FROM" "$RELEASE"

    # Iterate over the types of messages specified
    for LEGALTYPE in $TYPES; do
        SHORT=$(echo "$LEGALTYPE" | cut -f1 -d';')
        LONG=$(echo "$LEGALTYPE" | cut -f2 -d';')
        subheading "$LONG" "$SHORT"
    done
}

if [ $SHLVL -eq 1 ] || [ $SHLVL -eq 2 ]; then
    # If this is being run as a command
    main "$@"
    >&2 echo -e "\033[0;33mBe sure to change headers, remove empty sections,"
    >&2 echo -e "and proofread before committing to CHANGELOG.md.\033[0m"
else
    # Otherwise this is being sourced
    unset -f main
    unset -f usage
fi
