#!/bin/bash

output=$(curl -s https://api.chucknorris.io/jokes/categories/ | jq -r ".[]")

debutPage="<html><head><title>Mes Blagues</title></head><body>"
finPage="</body></html>"

baliseH2Ouvrante="<h2>"
baliseH2Fermante="</h2>"

declare -a monTableau
recommence=true

while $recommence;
    do
        echo "Salut, tu veux une blague sur chuck norris ?"
        read reponse

        if [ $reponse = oui ]
            then
                blague=$(curl -s https://api.chucknorris.io/jokes/random | jq -r '.value')
        else
            echo "Tiens, voilà la liste des catégories"
        for categorie in ${output[@]}
            do
                echo $categorie
        done
            echo "--------------------------"
            echo "Choisis une catégorie"
            read choix
            blague=$(curl -s https://api.chucknorris.io/jokes/random?category=$choix | jq -r '.value')
        fi

        echo $blague
        echo "on la garde celle là ?"
        read garder
        if [ $garder = oui ]
            then
                monTableau+=("$blague")
        fi

        echo "encore une ?"
        read encoreUne

        if [ $encoreUne != "oui" ]
            then
                recommence=false
        fi
    done

echo "--------------"
echo "ça te dirait de les noter dans un fichier texte ? Oui ? Non ?"
read ouiOuNon

if [ $ouiOuNon = oui ]
    then
        pageWeb=""
        pageWeb+=$debutPage
        for blagueChuck in "${monTableau[@]}"
            do
                blagueHtml=""
                blagueHtml+=$baliseH2Ouvrante
                blagueHtml+="$blagueChuck"
                blagueHtml+=$baliseH2Fermante

                pageWeb+=$blagueHtml
            done
        pageWeb+=$finPage

        echo $pageWeb > index.html
        cp index.html /var/www/html/index.html
fi