vim.cmd [[highlight! link SnapPosition Type]]

local snap = require'snap'
snap.register.map('n', '<C-p>', snap.create(function ()
  return {
    producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'}
  }
end))

snap.register.map('n', '<C-f>', snap.create(function ()
  return {
    producer = snap.get'consumer.limit'(100, snap.get'producer.ripgrep.vimgrep'),
    select = snap.get'select.vimgrep'.select,
    multiselect = snap.get'select.vimgrep'.multiselect,
    views = {snap.get'preview.vimgrep'}
  }
end))

snap.register.map('n', '<C-b>', snap.create(function ()
  return {
    producer = snap.get'consumer.fzf'(snap.get'producer.vim.buffer'),
    select = snap.get'select.file'.select,
    views = {snap.get'preview.file'}
  }
end))
