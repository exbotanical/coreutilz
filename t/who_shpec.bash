ROOT_DIR="$(dirname "$(readlink -f $BASH_SOURCE)")"

# shellcheck source=utils/shpec_utils.bash
. "$ROOT_DIR/utils/shpec_utils.bash"

# https://stackoverflow.com/questions/60699218/who-and-w-commands-in-centos-8-docker-container
[[ -z $(cat /proc/self/cgroup | grep -oP '(?<=0::/).*') ]] && {
  return 0
}

describe 'who program'
  it 'runs'
    me="$(whoami)"
    out="$(./bin/who)"

    assert egrep "$out" "^$me.*$d4-$d2-$d2 $d2:$d2$"
  ti
end_describe
