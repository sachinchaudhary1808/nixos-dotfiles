#!/usr/bin/env bash
grim -g "$(slurp)" - |tesseract  stdin stdout | wl-copy
