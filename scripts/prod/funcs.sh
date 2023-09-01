function git_add_commit () {
    FILES="${1}"
    COMMENT="${2}"

    git add $FILES && git commit -m "$COMMENT"
}

function git_push () {
    BRANCH="${1}"

    git push origin $BRANCH
}