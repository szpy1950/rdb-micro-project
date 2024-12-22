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
    - Table `Line`:
      - `startStationId` et `endStationId` sont des clés étrangères qui pointent vers la table `Station`.
    - Les tables `Line` et`Segment` sont aussi reliées par `Path` et `PathSegment`

2. Relation entre `Path`, `Train`, et `TrainType`
    - Table `Path` : fait référence à la table `TrainType`.
    - Table `Train` : fait référence à la table `TrainType`.
    - Table `TrainPath` : lie `Path` et `Train`.

Gestion des relations circulaires:
| Relation | Action recommandée |
|----------|:------------------:|
| `Segment` → `Station` | `ON DELETE CASCADE` |
| `Line` → `Station` |  `ON DELETE CASCADE` |
| `PathSegment` → `Path` | `ON DELETE CASCADE` |
| `TrainPath` → `Path` et `Train` | `ON DELETE CASCADE / SET NULL` |

## Prérequis
Avant d'installer et d'exécuter ce projet, assurez-vous d'avoir :

- **PostgreSQL** installé
- (Optionnel) **git** pour cloner le dépôt

## Installation
1. **Clonez le dépôt** :
   ```bash
   git clone https://github.com/LordBaryhobal/rdb-micro-project.git
   cd rdb-micro-project
   ```
2. **Créez la base de données** :
   ```sql
   CREATE DATABASE rrs_rail_suisse;
   ```
3. **Importez le schéma SQL** :
    ```bash
    psql -U utilisateur -d rrs_rail_suisse -f schema.sql
    ```
4. **Importez les données** :
    ```bash
    psql -U utilisateur -d rrs_rail_suisse -f data.sql
    ```
5. **Testez les requêtes**

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