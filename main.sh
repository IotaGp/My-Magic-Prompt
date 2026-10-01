#!/bin/bash
source .env
source quit.sh
source help.sh

# Vérifier si le fichier .env existe
if [ -f .env ]; then
    # Lire ligne par ligne, ignorer les espaces (IFS=) et garder le texte brut (-r)
    while IFS= read -r line || [ -n "$line" ]; do
        # 1. Ignorer les lignes vides
        # 2. Ignorer les commentaires commençant par #
        if [[ ! -z "$line" && ! "$line" =~ ^# ]]; then
            # Exporter la variable
            export "$line"
        fi
    done < .env
else
    echo "Erreur : Le fichier .env est introuvable."
    exit 1
fi


verify() {
  echo "Identifiant :"
  read Identifiant
  if [ $Identifiant != $Username ]; then
    quit
    else echo "Mot de passe"
    fi
  read -s Mot_de_passe
  if [ $Mot_de_passe != $Password ]; then
  quit
  else echo "Accès Autorisé ! Bienvenue sur votre session Maître ! ♡"
  fi
}

*() {
  echo "Commande inconnue"
}

httpget() {
  echo "Nom du fichier"
  read Nom_fichier
  wget $Nom_fichier
}

smtp() {
  echo "Destinataire"
  read Destinataire
  echo "Sujet"
  read Sujet
  echo "Message"
  read Message
  echo $Message | mail -s $Sujet $Destinataire

}

open() {
  echo "Nom du fichier ?"
  read Nom_fichier
  vim $Nom_fichier
}

profil() {
  echo "Ton prenom ?"
  read ton_prenom
  echo "Ton nom ?"
  read ton_nom
  echo "Ton age ?"
  read ton_age
  echo "Ton email ?"
  read ton_email
  echo "Prénom :" $ton_prenom , "Nom :" $ton_nom , "Âge :" $ton_age , "Email :" $ton_email
}

about() {
  echo "Ce programme crée un terminal dans un terminal"
}

version() {
  echo "version 1.0.0"
}

âge() {
  echo "Quel âge avez-vous ?"
  read ton_âge
  if [ $ton_âge -ge 18 ]; then
  echo "Vous êtes majeur"
  else 
  echo "Vous êtes mineur"
  fi
}

cmd() {
  cmd=$1
  argv=$*

  case "${cmd}" in
    help ) help;;
    quit | exit ) quit;;
    ls ) ls;;
    rm ) rm $*;;
    rmdir ) rmdir $*;;
    pwd ) pwd;;
    about ) about;;
    version ) version;;
    âge ) âge;;
    profil ) profil;;
    passw ) passwd;;
    cd ) cd;;
    hour ) date;;
    httpget ) httpget;;
    smtp ) smtp;;
    open ) open;;
    * ) *;;
  esac
}

main() {
  lineCount=1

  while [ 1 ]; do
    date=$(date +%H:%M)
    echo -ne "${date} - [\033[31m${lineCount}\033[m] - \033[33mXzen\033[m ~ ☠️ ~ "
    read string

    cmd $string
    lineCount=$(($lineCount+1))
  done
}

verify
main
