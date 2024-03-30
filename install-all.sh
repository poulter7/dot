#!/bin/bash
set -e  # exit on error
for f in ./install/**/*.sh; do
  bash "$f"
done
