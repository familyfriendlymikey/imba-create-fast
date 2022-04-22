import { readFileSync, writeFileSync } from 'fs'
import { execSync } from 'child_process'
execSync 'imbac imba-create-fast.imba', { stdio:'inherit' }
let data = readFileSync 'imba-create-fast.js', { encoding: 'utf-8' }
writeFileSync 'imba-create-fast.js', "#!/usr/bin/env node\n" + data
