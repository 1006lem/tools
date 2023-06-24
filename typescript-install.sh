#!/bin/bash

if ! command -v npm &> /dev/null; then
    echo "install Node.js and npm first.."
    exit 1
fi
 
sudo npm install -g typescript


cat <<EOF > tsconfig.json
{
    "compilerOptions": {
        "target": "es6",
        "module": "commonjs",
        "noImplicitAny": true,
        "removeComments": true,
        "preserveConstEnums": true,
        "sourceMap": true
    }
}
EOF

echo "typescript installed.."
