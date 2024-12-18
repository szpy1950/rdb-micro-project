# RRS: Les Routes du Rail Suisse



<img src="diagram.png">


## Description de la Base de Données

Ce projet décrit une base de données relationnelle conçue pour gérer les routes ferroviaires en Suisse. Voici les principaux composants :

- **Segment** : Représente une portion spécifique d'une ligne entre deux stations.
- **Station** : Les gares où les passagers peuvent monter ou descendre.
- **Line** : Définit les lignes ferroviaires connectant deux stations de départ et d'arrivée.
- **Path** : Parcours spécifique d'un train incluant plusieurs segments.
- **Train** : Informations sur les trains, incluant leur type et leur capacité.
- **TrainType** : Catégorie d'un train (par exemple, train régional, intercity).
- **Ticket** : Billets émis aux clients pour voyager entre deux stations.
- **Customer** : Informations sur les passagers.
- **City** : Les villes où se situent les gares.

Notre schéma respecte les règles de la troisième forme normale (3NF). Toutes les colonnes non-clé dépendent uniquement de la clé primaire, et il n'y a ni redondance ni dépendance transitive.

### Relations circulaires

1. Relation entre `Segment`, `Station` et `Line`
    - Table `Segment` :
        - `fromStationId` et `toStationId` sont des clés étrangères qui pointent vers la table `Station`.
        - La table `Line` fait référence à des stations via `startStationId` et `endStationId` (table `Station`).
    > **Relation circulaire implicite :
    Les segments utilisent des stations, mais ces stations peuvent être liées à une ligne. Si on supprime une station, il faut gérer les segments et lignes associés.**

2. Relation entre `Path`, `PathSegment`, et `TrainPath`
    - Table `Path` : Elle fait référence à la table `Line`.
    - Table `PathSegment` : Elle dépend de `Path` (clé étrangère `pathId`) et relie des `Segments`.
    - Table `TrainPath` : Elle dépend de `Path` et de `Train` (via `pathId` et `trainId`).
    > **Relation circulaire implicite :
    Si vous supprimez un Path, il faut supprimer les entrées dans PathSegment et TrainPath.**

Gestion des relations circulaires:
| Relation | Action recommandée | 
|----------|:------------------:|
| `Segment` -> `Station` | `ON DELETE CASCADE` |
| `Line` -> `Station` |  `ON DELETE CASCADE` |
| `PathSegment` -> `Path` | `ON DELETE CASCADE` |
| `TrainPath` → `Path` et `Train` | `ON DELETE CASCADE / SET NULL` |
## Prérequis

Avant d'installer et d'exécuter ce projet, assurez-vous d'avoir :

- **PostgreSQL** installé.
- Un éditeur SQL.
- **Git** pour cloner le dépôt.

## Installation

1. **Clonez le dépôt** :
   ```bash
   git clone https://github.com/username/rrs-rail-suisse.git
   cd rrs-rail-suisse
   ```
2. **Créez la base de données** dans votre SGBD :
   ```sql
   CREATE DATABASE rrs_rail_suisse;
   ```
3. **Importez le script SQL** contenant le schéma de la base de données :
    ```bash
    psql -U utilisateur -d rrs_rail_suisse -f schema.sql
    ```
4. **Importez les données**
5. **Importez les usefuls queries**

## Requêtes
Cette requête permettra de faire des choses vraiment super.
```sql
Ma requête trop super
```
Pour cette requête, aucun index ne sera nécessaire.

## Améliorations futures

- Ajouter une table **Schedule** pour gérer les horaires des trains.
- Implémenter des contraintes pour éviter les chevauchements de segments.
- Ajouter une table **Reservation** pour permettre la réservation de places spécifiques dans un train.
- Intégrer un système d'authentification pour les clients.