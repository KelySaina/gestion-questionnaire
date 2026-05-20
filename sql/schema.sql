-- Gestion des Questionnaires - schema MySQL
CREATE DATABASE IF NOT EXISTS gestion_questionnaires
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE gestion_questionnaires;

DROP TABLE IF EXISTS EXAMEN;
DROP TABLE IF EXISTS QCM;
DROP TABLE IF EXISTS ETUDIANT;

CREATE TABLE ETUDIANT (
    num_etudiant   VARCHAR(20)  NOT NULL PRIMARY KEY,
    nom            VARCHAR(80)  NOT NULL,
    prenoms        VARCHAR(120) NOT NULL,
    niveau         ENUM('L1','L2','L3','M1','M2') NOT NULL,
    adr_email      VARCHAR(150) NOT NULL
);

CREATE TABLE QCM (
    num_quest      INT AUTO_INCREMENT PRIMARY KEY,
    question       VARCHAR(500) NOT NULL,
    reponse1       VARCHAR(255) NOT NULL,
    reponse2       VARCHAR(255) NOT NULL,
    reponse3       VARCHAR(255) NOT NULL,
    reponse4       VARCHAR(255) NOT NULL,
    bonne_reponse  TINYINT      NOT NULL CHECK (bonne_reponse BETWEEN 1 AND 4)
);

CREATE TABLE EXAMEN (
    num_exam       INT AUTO_INCREMENT,
    num_etudiant   VARCHAR(20)  NOT NULL,
    annee_univ     VARCHAR(9)   NOT NULL, -- format 2022-2023
    note           INT          NOT NULL,
    date_exam      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (num_exam, num_etudiant),
    CONSTRAINT fk_examen_etudiant FOREIGN KEY (num_etudiant)
        REFERENCES ETUDIANT(num_etudiant) ON DELETE CASCADE
);

-- Jeu de donnees d'exemple
INSERT INTO ETUDIANT VALUES
 ('E001','Diallo','Mamadou','L1','mamadou@example.com'),
 ('E002','Kone','Awa','L2','awa@example.com'),
 ('E003','Traore','Issa','M1','issa@example.com');

INSERT INTO QCM (question, reponse1, reponse2, reponse3, reponse4, bonne_reponse) VALUES
 ('Capitale de la France ?','Paris','Lyon','Marseille','Lille',1),
 ('2 + 2 = ?','3','4','5','22',2),
 ('Langage du Web cote client ?','Java','PHP','JavaScript','C++',3),
 ('Auteur des Miserables ?','Zola','Hugo','Balzac','Camus',2),
 ('SQL signifie ?','Strong Query Lang','Structured Query Language','System Query Logic','Simple Quick Lang',2),
 ('HTTP port par defaut ?','21','22','80','443',3),
 ('git commit cree ?','Une branche','Un tag','Un instantane','Un fichier',3),
 ('Couleur RGB(255,0,0) ?','Vert','Bleu','Rouge','Jaune',3),
 ('Type primitif Java ?','String','int','List','Date',2),
 ('Annee independance Cote d''Ivoire ?','1958','1960','1962','1965',2),
 ('Continent du Mali ?','Asie','Europe','Afrique','Amerique',3),
 ('JVM signifie ?','Java Virtual Machine','Just Verified Method','Java Visible Module','Joint Var Manager',1);
