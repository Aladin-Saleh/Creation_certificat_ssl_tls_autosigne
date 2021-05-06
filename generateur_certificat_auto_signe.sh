#!/bin/bash

rougefonce='\e[0;31m'
vertclair='\e[1;32m'


if (($#==1))
then

re='^[0-9]+$'
if ! [[ $1 =~ $re ]] ; then
   echo -e "${rougefonce}ERREUR : LA VALEUR QUE VOUS AVEZ ENTEZ N'EST PAS VALIDE ! VEUILLEZ ENTRER UN NOMBRE DE JOUR (ENTIER) !" >&2; exit 1
fi

mkdir certificat
cd certificat
clear
echo -e "${vertclair}Un nouveau repertoire contanant votre certificat à été créer !"
echo -e "${vertclair}Creation de la clé..."
openssl genrsa -out key.pem
openssl req -new -key key.pem -out csr.pem

clear
echo -e "${vertclair}Creation du certificat..."
echo -e "${vertclair}Vous avez choisi de définir une durée de $1"
openssl x509 -req -days $1 -in csr.pem -signkey key.pem -out cert.pem 
else

mkdir certificat
cd certificat
clear
echo -e "${vertclair}Un nouveau repertoire contanant votre certificat à été créer !"
echo -e "${vertclair}Creation de la clé..."
openssl genrsa -out key.pem
openssl req -new -key key.pem -out csr.pem

clear
echo -e "${vertclair}Creation du certificat..."
echo -e "${vertclair}Durée du certificat : 365 jours (valeur par défault)"
openssl x509 -req -days 365 -in csr.pem -signkey key.pem -out cert.pem
fi


echo -e "${vertclair}Votre certificat à été créer avec succès !"
