import { readFileSync, writeFileSync } from 'fs'
import { execSync } from 'child_process'
execSync 'imbac -o dist imba-create-fast.imba'
let data = readFileSync 'dist/imba-create-fast.js', { encoding: 'utf-8' }
writeFileSync 'dist/imba-create-fast.js', "#!/usr/bin/env node\n" + data
