select *
from client;

select *
from client
where notelephone = '(999)999-9999';

select nocommande, datecommande
from commande
where noclient = 10 AND nocommande > 2;

select noarticle, description
from article
where prixunitaire < 20 and prixunitaire > 10;

select client.noclient, notelephone, datecommande
from commande, client
where datecommande = '2019-01-06';

select distinct noarticle
from article, commande
where noclient = 10 and datecommande > '2019-01-06';

select distinct nolivraison
from detaillivraison
join commande c on detaillivraison.nocommande = c.nocommande
where c.noclient = 10;

select distinct  dl.nolivraison
from detaillivraison dl
join commande c on dl.nocommande = c.nocommande
join client cl on c.noclient = cl.noclient
where cl.nomclient = 'Luc Sansom';

select noclient, nomclient
from client cl
where not EXISTS (
    SELECT 1
    from commande c
    where c.noclient = cl.noclient
    and extract(year from c.datecommande) = 2019
    and extract(month from c.datecommande) = 5
);

select noclient, nomclient
from client cl
where EXISTS (
    SELECT 1
    from commande c
    where c.noclient = cl.noclient
      and extract(year from c.datecommande) = 2019
      and extract(month from c.datecommande) = 5
);

select noarticle
from lignecommande
group by noarticle
having count(distinct nocommande) = (SELECT COUNT(*) from commande);









