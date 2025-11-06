if exists('current_compiler')
  finish
endif

let current_compiler = 'node'

CompilerSet makeprg=node\ %
