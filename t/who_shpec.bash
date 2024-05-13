ROOT_DIR="$(dirname "$(readlink -f $BASH_SOURCE)")"

# shellcheck source=utils/shpec_utils.bash
. "$ROOT_DIR/utils/shpec_utils.bash"

describe 'who program'
  it 'runs'
    me="$(whoami)"
    out="$(./bin/who)"

    assert egrep "$out" "^$me.*$d4-$d2-$d2 $d2:$d2$"
  ti
end_describe
