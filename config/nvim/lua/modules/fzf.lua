local vimp = require("vimp")
vimp.nnoremap({'override'}, '<C-p>', ':Files<CR>')
vimp.nnoremap({'override'}, '<C-b>', ':Buffers<CR>')
vimp.nnoremap({'override'}, '<C-f>', ':Rg<CR>')
