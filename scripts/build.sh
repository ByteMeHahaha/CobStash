#!/usr/bin/env bash

cobc -I ../src/copy \
  -free \
  -x ../src/main.cob \
  -o ../bin/CobStash \
  -w -q
