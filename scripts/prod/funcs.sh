function git_add_commit () {
    FILES="${1}"
    COMMENT="${2}"

    git add $FILES && git commit -m "$COMMENT"
}

function git_push () {
    BRANCH="${1}"

    echo "BRANCH '${BRANCH}'"

    [ -z "${BRANCH}" ] && BRANCH="$(git branch | grep '*' | awk '{print $2}')"
    git push origin $BRANCH
}