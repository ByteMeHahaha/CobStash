#!/usr/bin/env bash

cobc -I ../src \
  -free \
  -x ../src/main.cob \
	-o ../bin/BinaryName \
  -w -q
