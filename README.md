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

### Passagers entre 2 gares à une date donnée
Cette requête compte le nombre de passagers ayant acheté un ticket reliant deux gares données à pour une date spécifique. À cause des limitations de notre modèle actuel, cette requête ne prend pas en compte les passagers passant entre ces deux gares sans qu'elles soient leurs point de départ, respectivement d'arrivée.

<details>
<summary>Montrer / Cacher</summary>

```sql
SELECT 
    COUNT(DISTINCT t.customerId) as total_passengers,
    s_from.stationName as from_station,
    s_to.stationName as to_station
FROM Ticket t
LEFT JOIN Station s_from ON t.fromStationId = s_from.id
LEFT JOIN Station s_to ON t.toStationId = s_to.id
WHERE '2024-12-31'::DATE BETWEEN DATE(t.validUntil) - INTERVAL '1 day'
                             AND DATE(t.validUntil)  -- Replace with your date
  AND t.fromStationId = 1  -- departure station
  AND t.toStationId = 3    -- arrival station
GROUP BY s_from.stationName, s_to.stationName;
```
</details>

### Passagers dépenciers
Cette requête liste les clients ayant acheté des tickets plus cher qu'un montant donné

<details>
<summary>Montrer / Cacher</summary>

```sql
SELECT DISTINCT 
    c.firstName,
    c.lastName,
    t.price
FROM Customer c
JOIN Ticket t ON c.id = t.customerId
WHERE t.price > 100.00  -- Replace with desired price
ORDER BY t.price DESC;
```
</details>

### Horaire de gare
Cette requête listes les départs depuis une gare donnée

<details>
<summary>Montrer / Cacher</summary>

```sql
SELECT 
    s.stationName,
    tp.departure,
    tt.trainTypeName
FROM Station s
JOIN Segment seg ON s.id = seg.fromStationId
JOIN PathSegment ps ON seg.id = ps.segmentId
JOIN Path p ON ps.pathId = p.id
JOIN TrainPath tp ON p.id = tp.pathId
JOIN Train t ON tp.trainId = t.id
JOIN TrainType tt ON t.typeId = tt.id
WHERE s.id = 1  -- Replace with station ID
ORDER BY tp.departure;
```
</details>

## Améliorations futures
- Ajouter une table **Schedule** pour gérer les horaires des trains.
- Implémenter des contraintes pour éviter les chevauchements de segments.
- Ajouter une table **Reservation** pour permettre la réservation de places spécifiques dans un train.
- Intégrer un système d'authentification pour les clients.