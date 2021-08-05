# iSCSI storage configuration

Ce document a pour objectif de permettre l'installation et la configuration d'une baie SAN pour la mise en place d'un stockage d'un cluster de viirtualisation Hyper-V. Ce stockage se base sur le protocole iSCSI (Internet Small Computer Systems Interface)

## Installation

### Prérequis

Cette documentation est valable pour l'installation d'une baie SAN sous Windows Server 2019.
Il vous faut :

1. connecter votre serveur dans le bon réseau

2. connaitre votre adresse réseaux pour votre stockage iscsi

#### OS

| composant | caractéristiques    |
| :-------- | :------------------ |
| OS        | Windows Server 2019 |
| CPU       | 2C                  |
| RAM       | 2048Mo              |
| HDD 1     | 40Go                |
| HDD 2     | 100Go               |
| Network   | 1card               |

### Installation du module

Une fois votre windows lancé, installez la feature iscsi
Pour cela, allez dans l'onglet "Manage", puis "add Roles and Features"
