#!/bin/bash



echo "Bonjour"

blagueRandom=$(curl -s https://api.chucknorris.io/jokes/random | jq -r '.value')

echo $blagueRandom