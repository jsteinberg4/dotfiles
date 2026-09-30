function clone_repo
    gh repo ls --json nameWithOwner -q '.[].nameWithOwner' | fzf | xargs gh repo clone
end
