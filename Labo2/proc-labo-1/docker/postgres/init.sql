create schema laboratoire2;

set search_path = laboratoire2, pg_catalog;


create table article (
                         noarticle            int4                 not null,
                         description          varchar(1024)        null,
                         prixunitaire         numeric              not null,
                         quantiteenstock      int4                 not null,
                         constraint pk_article primary key (noarticle)
);

create table client (
                        noclient             int4                 not null,
                        nomclient            varchar(64)          not null,
                        notelephone          varchar(14)          null,
                        constraint pk_client primary key (noclient)
);

create table commande (
                          nocommande           int4                 not null,
                          noclient             int4                 null,
                          datecommande         date                 not null,
                          constraint pk_commande primary key (nocommande)
);


create table detaillivraison (
                                 nocommande           int4                 not null,
                                 noarticle            int4                 not null,
                                 nolivraison          int4                 not null,
                                 quantitelivree       int4                 null,
                                 constraint pk_detaillivraison primary key (nocommande, noarticle, nolivraison)
);

create table lignecommande (
                               nocommande           int4                 not null,
                               noarticle            int4                 not null,
                               quantite             int4                 null,
                               constraint pk_lignecommande primary key (nocommande, noarticle)
);


create table livraison (
                           nolivraison          int4                 not null,
                           datelivraison        date                 not null,
                           constraint pk_livraison primary key (nolivraison)
);

alter table commande
    add constraint fk_commande_relations_client foreign key (noclient)
        references client (noclient)
        on delete restrict on update restrict;

alter table detaillivraison
    add constraint fk_detailli_relations_lignecom foreign key (nocommande, noarticle)
        references lignecommande (nocommande, noarticle)
        on delete cascade on update restrict;

alter table detaillivraison
    add constraint fk_detailli_relations_livraiso foreign key (nolivraison)
        references livraison (nolivraison)
        on delete restrict on update restrict;

alter table lignecommande
    add constraint fk_lignecom_relations_commande foreign key (nocommande)
        references commande (nocommande)
        on delete cascade on update restrict;

alter table lignecommande
    add constraint fk_lignecom_relations_article foreign key (noarticle)
        references article (noarticle)
        on delete restrict on update restrict;



insert into client values(10,'Luc Sansom','(999)999-9999');
insert into client values(20,'Dollard Tremblay','(888)888-8888');
insert into client values(30,'Lin B','(777)777-7777');
insert into client values(40,'Jean Leconte','(666)666-6666');
insert into client values(50,'Hafed Alaoui','(555)555-5555');
insert into client values(60,'Marie Leconte','(666)666-6666');
insert into client values(70,'Simon Lecoq','(444)444-4419');
insert into client values(80,'Dollard Tremblay',null);

insert into article values(10,'Cadre en boule',10.99,10);
insert into article values(20,'Sapin',12.99,10);
insert into article values(40,'Epinette bleue',25.99,10);
insert into article values(50,'Chaine',22.99,10);
insert into article values(60,'Érable argent',15.99,10);
insert into article values(70,'Herbe puce',10.99,10);
insert into article values(80,'Poirier',26.99,10);
insert into article values(81,'Catalpa',25.99,10);
insert into article values(90,'Pommier',25.99,10);
insert into article values(95,'Genvrier',15.99,10);

insert into commande values(1, 10, '2019-01-06');
insert into commande values(2, 20, '2019-02-06');
insert into commande values(3, 10, '2019-02-06');
insert into commande values(4, 10, '2019-05-07');
insert into commande values(5, 30, '2019-07-09');
insert into commande values(6, 20, '2019-07-09');
insert into commande values(7, 40, '2019-07-15');
insert into commande values(8, 40, '2019-07-15');

insert into lignecommande values(1,10,10);
insert into lignecommande values(1,70,5);
insert into lignecommande values(1,90,1);
insert into lignecommande values(2,10,2);
insert into lignecommande values(2,40,2);
insert into lignecommande values(2,95,3);
insert into lignecommande values(3,10,1);
insert into lignecommande values(3,20,1);
insert into lignecommande values(3,70,5);
insert into lignecommande values(4,10,1);
insert into lignecommande values(4,40,1);
insert into lignecommande values(4,50,1);
insert into lignecommande values(4,70,5);
insert into lignecommande values(5,70,3);
insert into lignecommande values(5,10,5);
insert into lignecommande values(5,20,5);
insert into lignecommande values(6,10,5);
insert into lignecommande values(6,40,1);
insert into lignecommande values(7,10,2);
insert into lignecommande values(7,50,1);
insert into lignecommande values(8,10,2);
insert into lignecommande values(8,20,3);

insert into livraison values(100,'2019-06-03');
insert into livraison values(101,'2019-06-04');
insert into livraison values(102,'2019-06-04');
insert into livraison values(103,'2019-06-05');
insert into livraison values(104,'2019-07-07');
insert into livraison values(105,'2019-07-08');


insert into detaillivraison values(1,10,100,7);
insert into detaillivraison values(1,70,100,5);
insert into detaillivraison values(1,10, 101,3);
insert into detaillivraison values(2,40,102,2);
insert into detaillivraison values(2,95,102,1);
insert into detaillivraison values(3,20,100,1);
insert into detaillivraison values(1,90,103,1);
insert into detaillivraison values(4,40,104,1);
insert into detaillivraison values(5,70,105,2);


