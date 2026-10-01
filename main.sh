#!/bin/bash
source quit.sh

help() {
  echo "quit - Quitter le prompt"
  echo "ls - Liste fichiers et dossiers, visibles comme cachés"
  echo "help Liste les commandes disponibles"
  echo "rm - Supprime un fichier"
  echo "rmdir - Supprime un dossier"
  echo "about - Description de votre programme"
  echo "version - Affiche la version du prompt"
  echo "âge - Demande votre âge : majeur ou mineur ?"
  echo "profil - Prénom, nom, âge et email"
  echo "passw - Change le mot de passe, avec confirmation"
  echo "cd - Va dans un dossier créé ou revient au précédent"
  echo "pwd - Affiche le répertoire courant"
  echo "hour - Donne l'heure actuelle"
  echo "* - Signale une commande inconnue"
  echo "httpget - Télécharge le HTML d'une page ; demande le nom du fichier"
  echo "smtp - Envoie un mail : adresse, sujet, corps"
  echo "open - Ouvre un fichier dans VIM, même s'il n'existe pas"
}

verify() {
  echo "Identifiant :"
  read Identifiant
  if [ $Identifiant != "Xzen" ]; then
    quit
    else echo "Mot de passe"
    fi
  read -s Mot_de_passe
  if [ $Mot_de_passe != "12345" ]; then
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
