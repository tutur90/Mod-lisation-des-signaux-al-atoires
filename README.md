# Modelisation des signaux aleatoires

L’objectif de ce projet est de mettre en œuvre une chaîne de codage et décodage de
la voix humaine utilisant le linear predictive coding (codage par prédition linéaire).
Une telle chaîne se retrouve dans des applications de transmission de la parole
économes en bande passante (voir normes GSM 06.10 ou LPC-10/FS-1015), où
l’objectif est d’extraire les caractéristiques minimales du signal à transmettre (étape
d’analyse du codeur) et d’être capable, à la réception, de synthétiser (codeur) un
signal dèle à l’original.
La maîtrise des étapes d’analyse et de synthèse ouvre également la voie à des
applications créatives où un eet est appliqué à la parole en suivant trois étapes :
— Analyse des caractéristiques de la parole.
— Manipulation de ces caractéristiques pour obtenir un eet désiré (par
exemple, changement de fréquence).
— Synthèse de la parole à partir des caractéristiques modiées.
On comparera les signaux réels et synthétiques avec les outils de traitement du
signal (autocorrélation, spectre) et à l’oreille.
