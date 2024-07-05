CREATE TABLE Personne
(
    nom INT NOT NULL,
    prenom INT NOT NULL,
    cip INT NOT NULL,
    role INT NOT NULL,
    PRIMARY KEY (cip)
);

CREATE TABLE Produit
(
    categorie INT NOT NULL,
    tempsEmprunt INT NOT NULL,
    categorie_id INT NOT NULL,
    PRIMARY KEY (categorie_id)
);

CREATE TABLE Une_personne_loue_un_produit
(
    Date INT NOT NULL,
    cip INT NOT NULL,
    categorie_id INT NOT NULL,
    PRIMARY KEY (Date),
    FOREIGN KEY (cip) REFERENCES Personne(cip),
    FOREIGN KEY (categorie_id) REFERENCES Produit(categorie_id),
    UNIQUE (cip, categorie_id)
);