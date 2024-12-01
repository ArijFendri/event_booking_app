# 🎫 Event Booking Application  

Une application Flutter pour réserver des événements, dotée d'une API MockAPI pour gérer les utilisateurs et les événements, ainsi qu'un serveur JSON pour la réservation des événements. L'application inclut l'authentification, la gestion des réservations, et des fonctionnalités modernes comme le mode sombre et clair, et les notifications.  

---  

## 📋 Fonctionnalités  

- **Authentification :**  
  - Inscription, connexion et déconnexion sécurisées.  
  - Validation des utilisateurs via une API MockAPI.  

- **Gestion des événements :**  
  - Liste des événements disponibles avec filtrage et recherche.  
  - Détails des événements avec description, lieu, date et prix.  

- **Panier :**  
  - Ajout d'événements au panier avec calcul dynamique des quantités et prix total.  
  - Suppression des articles du panier.  

- **Paiement et QR Code :**  
  - Formulaire de paiement pour réserver des billets.  
  - Génération d'un QR code pour chaque réservation réussie.  

- **Mode sombre et clair :**  
  - Basculer entre les thèmes en fonction de vos préférences.  

- **Notifications :**  
  - Alertes pour les nouveaux événements à venir.  

- **Historique des réservations :**  
  - Liste des réservations passées.  

- **Design responsive :**  
  - Adapté pour fonctionner sur mobile, tablette et grand écran.  

---  

## 🛠️ Technologies utilisées  

- **Frontend :** Flutter  
- **Backend simulé :**  
  - [MockAPI](https://mockapi.io/) pour gérer les données des utilisateurs et des événements :  
    - **Endpoints :**  
      - [Utilisateurs](https://mockapi.io/projects/6744e241b4e2e04abea3f4bd/user)  
      - [Événements](https://mockapi.io/projects/6744e241b4e2e04abea3f4bd/events)  
  - JSON Server pour simuler une API REST locale, Démarrez le serveur JSON avec :  
    ```bash
    json-server --watch db.json --port 3000
    ```  

---  

## 🚀 Configuration et exécution  

### Clonez le projet  
```bash  
git clone https://github.com/votre-utilisateur/votre-repo.git  
cd votre-repo  
flutter pub get  
flutter run  
