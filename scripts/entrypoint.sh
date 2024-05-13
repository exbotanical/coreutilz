#!/bin/sh -l

make -s test 2>/dev/null
exit $?
