#!/bin/bash

cd $(dirname $(realpath "$0"))

dart compile exe ../lib/main.dart -o ../bin/git-conventional-commit
cp ../bin/git-conventional-commit ~/.local/bin/
