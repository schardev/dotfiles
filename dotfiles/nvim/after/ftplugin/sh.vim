" Let ALE autofix bash files
let b:ale_fix_on_save = 1

" Easy shebang abbrevation
inoreabbrev <buffer> <expr> #! col('.') == 3 && getline('.') =~ "^#" ?
            \ "#!/bin/bash" : "#!"
