
tmux new-session -d -s $ALI_WHAT
tmux splitw -d -t 0 -h
tmux select-pane -t 0
tmux send-keys -t 1 'cd /alicesw/sw/BUILD/$ALI_WHAT-latest-$ALI_VERSION/$ALI_WHAT' enter
tmux attach
