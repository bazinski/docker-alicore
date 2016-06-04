#!/bin/zsh
#
# run a container with the source locally on the Mac
# and the build/install in a managed docker container
# 

getmyip() { 
    ifconfig en3 2> /dev/null | grep --color=auto inet | awk '$1=="inet" {print $2}' && ifconfig en0 2> /dev/null | grep --color=auto inet | awk '$1=="inet" {print $2}'
}

xquartz_if_not_running() {
    v_nolisten_tcp=$(defaults read org.macosforge.xquartz.X11 nolisten_tcp)
    v_xquartz_app=$(defaults read org.macosforge.xquartz.X11 app_to_run)

    if (( $v_nolisten_tcp == 1 )); then
        defaults write org.macosforge.xquartz.X11 nolisten_tcp 0
    fi

    if [ $v_xquartz_app != "/usr/bin/true" ]; then
        defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true
    fi

    netstat -an | grep 6000 &> /dev/null || open -a XQuartz
    while ! netstat -an | grep 6000 &> /dev/null; do
        sleep 2
    done
    xhost + $(getmyip)
    export DISPLAY=:0
}

what=${1:="AliRoot"}
whatlc=$what:l

version=${2:="feature-reco-2016"}

echo $version

xquartz_if_not_running
ip=$(getmyip)

docker run --interactive --tty \
    --rm \
    --name "$version" \
    --env "DISPLAY=${ip}:0" --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --env "ALI_WHAT=$what" \
    --env "ALI_VERSION=$version" \
    --hostname "$version" \
    --volumes-from vc_run2_sw \
    --volume $HOME/.globus:/root/.globus \
    --volume $HOME/alicesw/run2/$whatlc-$version/alidist:/alicesw/alidist \
    --volume $HOME/alicesw/run2/$whatlc-$version/$what:/alicesw/AliRoot \
    --volume $HOME/alicesw/repos/$what:$HOME/alicesw/repos/$what \
    aphecetche/centos7-ali-core 
