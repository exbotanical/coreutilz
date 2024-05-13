set -o errexit

for_each () {
  local fn=$1

  shift

  local -a arr=($@)

  for item in "${arr[@]}"; do
    $fn $item
  done
}

filter () {
  local fn=$1
  local suffix=$2
  local arg

  while read -r arg; do
    $fn $arg $suffix && echo $arg
  done
}

not_test_file () {
	local test=$1
  local suffix=$2
	local ret=0

  if [[ $test != *$suffix ]]; then
     return 1;
  fi

	for (( i=0; i < ${#SKIP_FILES[@]}; i++ )); do
		if [[ $test == ${SKIP_FILES[i]} ]]; then
			ret=1
			break
		fi
	done

	return $ret
}
