#!/bin/bash

# sincroniza as pastas
rsync -av --delete $HOME/.config/nvim/ ./nvim/

