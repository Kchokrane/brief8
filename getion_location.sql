/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  27/04/2020 21:49:08                      */
/*==============================================================*/
/* creation de base de donnes */
CREATE DATABASE IF NOT EXISTS gestion_location;
/*USE location;*/
USE gestion_location;


drop table if exists APPARTEMENT;

drop table if exists CONCERNE;

drop table if exists CONTRAT;

drop table if exists LOCATAIRE;

drop table if exists PROPRIETAIRE;

drop table if exists TARIF;

/*==============================================================*/
/* Table : APPARTEMENT                                          */
/*==============================================================*/
create table APPARTEMENT
(
   NUM_LOCATION         int not null,
   CODE_TARIF           int not null,
   NUM                  int not null,
   TYPE                 text,
   NB_PERSO             int,
   ADRESSE_LOCATION     text,
   primary key (NUM_LOCATION)
);

/*==============================================================*/
/* Table : CONCERNE                                             */
/*==============================================================*/
create table CONCERNE
(
   NUM_CONT             int not null,
   NUM_LOCATAIRE        int not null,
   primary key (NUM_CONT, NUM_LOCATAIRE)
);

/*==============================================================*/
/* Table : CONTRAT                                              */
/*==============================================================*/
create table CONTRAT
(
   NUM_CONT             int not null,
   NUM_LOCATION         int not null,
   ETAT                 text,
   DATE_RES             date,
   DATE_RETOUR          date,
   primary key (NUM_CONT)
);

/*==============================================================*/
/* Table : LOCATAIRE                                            */
/*==============================================================*/
create table LOCATAIRE
(
   NUM_LOCATAIRE        int not null,
   NOM_LOC              text,
   PRENOM_LOC           text,
   ADRESSE_LOC          text,
   NUM_TEL_LOC          text,
   EMAIL_LOC            text,
   primary key (NUM_LOCATAIRE)
);

/*==============================================================*/
/* Table : PROPRIETAIRE                                         */
/*==============================================================*/
create table PROPRIETAIRE
(
   NUM                  int not null,
   NOM                  text,
   PRENOM               text,
   ADRESSE_PRO          text,
   EMAIL                text,
   VILLE                text,
   primary key (NUM)
);

/*==============================================================*/
/* Table : TARIF                                                */
/*==============================================================*/
create table TARIF
(
   CODE_TARIF           int not null,
   PRIX_HS              text,
   PRIX_TT              text,
   primary key (CODE_TARIF)
);
insert  into `TARIF`(`CODE_TARIF`,`PRIX_HS`,`PRIX_TT`) values (15,1500dh,2000dh);

/*foreing key constraint*/

alter table APPARTEMENT add constraint FK_CORESPOND foreign key (CODE_TARIF)
      references TARIF (CODE_TARIF) on delete restrict on update restrict;

alter table APPARTEMENT add constraint FK_POSSEDE foreign key (NUM)
      references PROPRIETAIRE (NUM) on delete restrict on update restrict;

alter table CONCERNE add constraint FK_CONCERNE foreign key (NUM_LOCATAIRE)
      references LOCATAIRE (NUM_LOCATAIRE) on delete restrict on update restrict;

alter table CONCERNE add constraint FK_CONCERNE2 foreign key (NUM_CONT)
      references CONTRAT (NUM_CONT) on delete restrict on update restrict;

alter table CONTRAT add constraint FK_LOUER foreign key (NUM_LOCATION)
      references APPARTEMENT (NUM_LOCATION) on delete restrict on update restrict;

      /*creation de user*/
      /*create user and donnes les permission*/
CREATE USER 'user'@'localhost' IDENTIFIED BY 'azerty';
GRANT ALL PRIVILEGES ON hotel TO 'user'@'localhost';
      /*requette*/
SELECT * FROM `appartement`;

Select AVG(type) from appartement,contrat where appartement.Num_location = contrat.Num_location And Date_res = "2020-11-03";

select AVG(type)from appartement INNER JOIN contrat on appartement.Num_location = contrat.Num_location where Date_res = "2020-11-03";

      /*update*/
update propreitaire SET ville = "SAFI" where PRENOM = "kamal";
      /*delete*/
DELETE FROM propreitaire
WHERE PRENOM = "kamal";