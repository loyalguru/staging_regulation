#!/bin/sh -l

set -e

main(){
    action=$(jq --raw-output .action ${GITHUB_EVENT_PATH})
    merged=$(jq --raw-output .pull_request.merged ${GITHUB_EVENT_PATH})
    branch=$(jq --raw-output .pull_request.head.ref ${GITHUB_EVENT_PATH})
    base=$(jq --raw-output .pull_request.base.ref ${GITHUB_EVENT_PATH})

    echo "DEBUG branch: ${branch} action: ${action} merged: ${merged}"

    if [[ ! "$branch" == "staging" ]] && [[ "$base" == "master" ]] && [[ "$action" == "closed" ]] && [[ "$merged" == "true" ]]; then
        title=$(jq --raw-output .pull_request.title ${GITHUB_EVENT_PATH})
        echo "DEBUG {\"title\":\"${title}\", \"head\":\"${branch}\", \"base\": \"staging\"}"
        echo "Creating Pull request for ${GITHUB_REPOSITORY}"
        curl -X POST "https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls" \
        -H "Authorization: token ${GITHUB_TOKEN}" \
        -d "{\"title\":\"${title}\", \"head\":\"${branch}\", \"base\": \"staging\"}"
        echo "Pull request created"
    fi
}

main "$@"
