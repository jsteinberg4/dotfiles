# Borrowed from lev

# --- Navigation ---
alias l='ls -lha'
alias lt='ls -ltrha'
alias pcp="rsync -r --progress"

alias h1='head -n 1'


# Show the most recently accessed files
function ltt
    ls -Gltrha $argv[1] | tail
end

# List most recently downloaded files
alias ltd='ltt ~/Downloads'

alias hh='history merge && history'
alias op='open .'
alias opr='open -R'

# Absolute path to a file in pwd
function abs
    echo (pwd)/$argv[1]
end

# Absolute path copy -- if file w/ name exists, copy absolute path to clipboard
function abc -a filename
    if not test -n "$filename"
        echo (pwd)/(ll | fzf  |  awk '{ print substr($9, 1, 500) } ') | tr -d '\n' | pbcopy
    else
        echo (pwd)/$filename | tr -d '\n' | pbcopy
    end
end

# Launch interactive awk program. Strip leading/trailing whitespaces from text
function strip
    awk '{$1=$1;print}'
end

# Copy pwd to clipboard and print it
function pp
    pwd | pbcopy
    pwd
end

# Paste copied path; cd into it
function cdp
    echo (pbpaste)
    cd (pbpaste)
end

# Replace any whitespaces in filename with underscores
function under
    set filename $argv[1]
    set good_name (echo $filename | tr -s ' ' | tr ', ()"\'' '_')
    mv -v $filename $good_name
end

# --- General ---
alias rgi='rg -i'
alias gnode='set PATH ~/npm-glob/bin $PATH'
alias gradle-kill="pkill -f '.*GradleDaemon.*'"

# --- Git ---
#alias append-commit='git add . && git commit --amend --no-edit'
alias gl='git log --oneline -10'
alias gm='git log --format=%B -n 1'
alias sts='git status'

function git-like
    git checkout $argv[1]
    git reset --soft mainline
    git commit -m $argv[2]
    git branch temp456
    git checkout mainline
    git merge temp456
    git branch -d temp456
end


# Kubectl sync - given the path to ..../django/project and a pod name
# It will sync the local files to the remote ones upon local file change
function kks -a source -a pod
    fswatch -o $source | while read f
        rsync -avurzP --blocking-io --exclude __pycache__ --rsync-path= --rsh="kubectl exec  -i $pod  -- " $source/* rsync:/
    end
end

# This will present an interactive menu with all your pods (adjust grep command - with your name)
# If you pass the script runner name - itll just connect to it (kk some-name)
# If you pass l as an argument (a la. kk l) it'll list all of your pods
# Note this will export an GLOBAL vairable to all of your shells LAST_POD_CONNECTED
function kk -a pod
    if [ "$pod" = l ]
        kubectl get pods | grep jesse #  <------   set your name here
    else if test -n "$pod"
        set --erase --global LAST_POD_CONNECTED
        set -xU LAST_POD_CONNECTED $pod
        echo "Copying config files"
        # kubectl cp /Users/jesse/PodSetup/configure_docker.bash $LAST_POD_CONNECTED:/root/project/configure_docker.bash
        # NOTE: changed filename to match comment in configure_docker.bash
        kubectl cp /Users/jesse/PodSetup/configure_docker.bash $LAST_POD_CONNECTED:/root/project/install_utils.sh
        kubectl cp /Users/jesse/PodSetup/docker_bashrc.bash $LAST_POD_CONNECTED:/root/.bashrc
        kubectl cp /Users/jesse/PodSetup/docker_tmux.conf $LAST_POD_CONNECTED:/root/.tmux.conf
        kubectl cp /Users/jesse/PodSetup/ipython_utils.py $LAST_POD_CONNECTED:/root/project/ipython_utils.py
        echo "Connecting to: $pod"
        kubectl exec -it $pod -- /bin/bash
    else
        set pod (kubectl get pods | rg jesse | fzf | awk '{print $1}')
        kk $pod
    end
end


# kubectl find (with my name)
function kkf
    set pod (kubectl get pods | rg jesse | fzf | awk '{print $1}')
    set -xU LAST_POD_CONNECTED $pod
    echo "Connecting to: $pod"
    kubectl exec -it $pod -- /bin/bash
end

# kubectl find from all
function kka
    set pod (kubectl get pods | fzf | awk '{print $1}')
    set -xU LAST_POD_CONNECTED $pod
    echo "Connecting to: $pod"
    kubectl exec -it $pod -- /bin/bash
end

# in case LAST_POD_CONNECTED is set, just connect to it (usefull for re-connecting)
function kkl
    if set -q LAST_POD_CONNECTED
        echo "Connecting to: $LAST_POD_CONNECTED"
        kubectl exec -it $LAST_POD_CONNECTED -- /bin/bash
    end
end

# in case LAST_POD_CONNECTED is set, copy a file from your project to the correct
# place inside the script runner
function kkc -a file
    if set -q LAST_POD_CONNECTED
        if string match -q -- '*django/project/*' $file && test -f $file
            set pod_filename (echo $file | sed 's/.*django\/project\///g')
            echo "Copying to $LAST_POD_CONNECTED:$pod_filename"
            kubectl cp $file $LAST_POD_CONNECTED:$pod_filename
        end
    end
end
