# Gestion des Questionnaires

Application web Java (JSP + Servlets + JDBC) implementant le **Projet 1**.

## Fonctionnalites

- CRUD `ETUDIANT` et `QCM` (6 pts)
- Recherche d'etudiant par numero ou nom avec `LIKE` (1 pt)
- Liste des etudiants inscrits par niveau avec l'effectif total (3 pts)
- Passage d'examen : 10 questions tirees au hasard dans `QCM`, note sur 10 enregistree dans `EXAMEN` (5 pts)
- Envoi automatique de la note par email (2 pts)
- Liste des notes (1 pt)
- Classement des etudiants par ordre de merite (2 pts)

## Stack

- Java 8+ (le pom est configure en 1.8 pour la compatibilite maximale ; fonctionne avec Java 11/17)
- Servlet 4.0 / JSP 2.3 / JSTL 1.2
- MySQL 8 + JDBC (mysql-connector-java)
- Envoi d'email via l'API HTTP **ks-mailer** (`https://ks-mailer.vercel.app/api/send`)
- Maven 3.6+ (packaging `war`)
- Tomcat 9 (embarque via `cargo-maven3-plugin` ou deploiement manuel)

## Prerequis

- JDK 8 ou superieur (`javac -version`)
- Maven (`mvn -v`) — installation : `choco install maven` (Windows) ou voir https://maven.apache.org/
- MySQL 8

## Mise en place

### 1. Base de donnees

```bash
mysql -u root -p < sql/schema.sql
```

### 2. Configuration

Copier les fichiers `*.example` :

```bash
cp src/main/resources/db.properties.example  src/main/resources/db.properties
cp src/main/resources/mail.properties.example src/main/resources/mail.properties
```

puis editer les valeurs (utilisateur MySQL, adresse expediteur).

Alternative : definir les variables d'environnement `DB_URL`, `DB_USER`, `DB_PASSWORD`,
`MAIL_API_URL`, `MAIL_FROM`.

> L'envoi d'email passe par l'API HTTP **ks-mailer**
> (`POST https://ks-mailer.vercel.app/api/send`) — aucun SMTP a configurer.

### 3. Construction et execution

Avec Tomcat embarque (le plus simple) :

```bash
mvn clean package cargo:run
```

Puis ouvrir http://localhost:8080/

Pour generer le war seul :

```bash
mvn clean package
# target/gestion-questionnaires.war
```

Le war est deployable dans un Tomcat 9 (copier dans `webapps/`).

## Arborescence

```
gestion-questionnaires/
  pom.xml
  sql/schema.sql
  src/main/
    java/com/gq/
      model/       (Etudiant, Qcm, Examen)
      dao/         (EtudiantDAO, QcmDAO, ExamenDAO)
      servlet/     (EtudiantServlet, QcmServlet, ExamenServlet)
      util/        (DBUtil, MailUtil)
    resources/     (db.properties, mail.properties)
    webapp/
      index.jsp
      css/style.css
      WEB-INF/
        web.xml
        tags/layout.tag
        views/*.jsp
```

## URLs

| URL                              | Role                                         |
|----------------------------------|----------------------------------------------|
| `/`                              | Accueil                                      |
| `/etudiants`                     | Liste + recherche (`?q=...`)                 |
| `/etudiants/new` `/edit` `/delete` | CRUD                                       |
| `/etudiants/niveaux`             | Effectifs par niveau + liste par niveau      |
| `/qcm` `/qcm/new` `/edit` `/delete` | CRUD questions                             |
| `/examen/start`                  | Choisir un etudiant et lancer un examen      |
| `/examen/passer` (POST)          | Affiche 10 questions aleatoires              |
| `/examen/soumettre` (POST)       | Calcule la note, enregistre, envoie l'email  |
| `/examen/notes`                  | Liste des notes                              |
| `/examen/classement`             | Classement par moyenne                       |
