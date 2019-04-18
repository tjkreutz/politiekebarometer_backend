-- Create all tables

CREATE TABLE `mentions`
(
	`id` int NOT NULL AUTO_INCREMENT,
	`pol_id` int,
	`fragment_id` int,
	PRIMARY KEY (`id`)
);

CREATE TABLE `fragments`
(
	`id` int NOT NULL AUTO_INCREMENT,
	`doc_id` int,
	`content` varchar(500),
	`sentiment` float,
	PRIMARY KEY (`id`)
);

CREATE TABLE `pol_all`
(
	`id` int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
);

CREATE TABLE `pol_parties`
(
	`id` int NOT NULL AUTO_INCREMENT,
	`pol_id` int,
	`short_name` varchar(50),
	`full_name` varchar(50),
	`no_of_members` int,
	`info` varchar(500),
	`twitter` varchar(50),
	`facebook` varchar(500),
	PRIMARY KEY (`id`)
);

CREATE TABLE `pol_persons`
(
	`id` int NOT NULL AUTO_INCREMENT,
	`pol_id` int,
	`first_name` varchar(50),
	`last_name` varchar(50),
	`full_name` varchar(50),
	`party_id` int,
	`info` varchar(500),
	`twitter` varchar(50),
	`facebook` varchar(500),
	PRIMARY KEY (`id`)
);

CREATE TABLE `doc_all`
(
	`id` int NOT NULL AUTO_INCREMENT,
	`date` datetime,
	`theme_name` varchar(50),
	`dossier_name` varchar(50),
	`url` varchar(500),
	PRIMARY KEY (`id`)
);

CREATE TABLE `doc_tweets`
(
	`tweet_id` varchar(50),
	`doc_id` int,
	`username` varchar(50),
	PRIMARY KEY (`tweet_id`)
);

CREATE TABLE `doc_news`
(
	`news_id` varchar(50),
	`doc_id` int,
	`source` varchar(50),
	PRIMARY KEY (`news_id`)
);

CREATE TABLE `themes`
(
	`name` varchar(50),
	`info` varchar(500),
	PRIMARY KEY (`name`)
);

CREATE TABLE `dossiers`
(
	`name` varchar(50),
	`info` varchar(500),
	PRIMARY KEY (`name`)
);

CREATE TABLE `hashtags`
(
	`pol_id` int,
	`rank` int,
	`hashtag` varchar(50),
  `count` int,
	PRIMARY KEY (`pol_id`, `rank`)
);
-- Create references between tables

ALTER TABLE `mentions` ADD FOREIGN KEY (`pol_id`) REFERENCES `pol_all` (`id`);

ALTER TABLE `mentions` ADD FOREIGN KEY (`fragment_id`) REFERENCES `fragments` (`id`);

ALTER TABLE `fragments` ADD FOREIGN KEY (`doc_id`) REFERENCES `doc_all` (`id`);

ALTER TABLE `pol_parties` ADD FOREIGN KEY (`pol_id`) REFERENCES `pol_all` (`id`) ON DELETE CASCADE;

ALTER TABLE `pol_persons` ADD FOREIGN KEY (`pol_id`) REFERENCES `pol_all` (`id`) ON DELETE CASCADE;

ALTER TABLE `pol_persons` ADD FOREIGN KEY (`party_id`) REFERENCES `pol_parties` (`id`);

ALTER TABLE `doc_all` ADD FOREIGN KEY (`theme_name`) REFERENCES `themes` (`name`);

ALTER TABLE `doc_all` ADD FOREIGN KEY (`dossier_name`) REFERENCES `dossiers` (`name`);

ALTER TABLE `doc_tweets` ADD FOREIGN KEY (`doc_id`) REFERENCES `doc_all` (`id`) ON DELETE CASCADE;

ALTER TABLE `doc_news` ADD FOREIGN KEY (`doc_id`) REFERENCES `doc_all` (`id`) ON DELETE CASCADE;

ALTER TABLE `hashtags` ADD FOREIGN KEY (`pol_id`) REFERENCES `pol_all` (`id`);

-- Populate the themes table

INSERT INTO themes(name, info) VALUES
("Economie","Het thema economie omvat alle zaken die te maken hebben met de algemeen economisch beleid en de economische situatie, arbeidsmarkt en werkgelegenheid en belastingen."),
("Mobiliteit","Het thema mobiliteit omvat alle zaken die gaan over verkeer en vervoer, bijvoorbeeld openbare werken, openbaar vervoer en wegeninfrastructuur."),
("Justitie","Het thema justitie omvat alle zaken die gaan over het algemeen justitiebeleid en veiligheid en criminaliteit."),
("Sociale zaken","Het thema sociale zaken omvat alle zaken die gaan over armoedebestrijding, sociale uitkeringen, sociale zekerheid in het algemeen en verwijzingen naar de welvaartsstaat."),
("Huisvesting","Het thema huisvesting omvat alle zaken die te maken hebben met de koop/huur van woningen, het algemeen huisvestingsbeleid, stedelijke ontwikkelingen en sociale woningen."),
("Ondernemingen","Het thema ondernemingen omvat alle zaken die gaan over het beleid ten aanzien van ondernemingen, handel en de financiële markt, zaken rond het bankwezen en zaken rond toerisme."),
("Defensie","Het thema defensie omvat alle zaken die te maken hebben met militaire operaties in het buitenland, het leger en landsverdediging."),
("Wetenschap","Het thema wetenschap omvat zaken die gaan over het algemeen onderzoeksbeleid, het bevorderen van innovatie, ruimtevaart, telecommunicatie, ICT, computers en het internet."),
("Buitenlandse handel","Het thema buitenlandse handel omvat alle zaken rond het Algemeen beleid t.a.v. buitenlandse en internationale handel, het algemeen EU handelsbeleid en algemene aspecten van handel."),
("Buitenlandse zaken","Het thema buitenlandse zaken omvat alle zaken omtrent ontwikkelingshulp, de EU, terrorisme en buitenlandse zaken."),
("Burgerrechten","Het thema burgerrechten omvat alle zaken die gaan over schendingen van mensenrechten en discriminatie naar sekse en seksuele geaardheid, discriminatie van gehandicapten en vrijheid van meningsuiting."),
("Werking partijen en overheid","Dit thema gaat over openbaar bestuur, ambtenarij, verkiezingen en politiek in het algemeen, overheidsbedrijven en het koninklijk huis."),
("Ruimtelijke ordening","Het thema ruimtelijke ordening omvat zaken die gaan over ruimtelijke ordeningsplannen, ontwikkeling van landschap en natuur, algemeen waterbeleid, bestemmingsplannen en bouwgrond"),
("Cultuur","Het thema cultuur omvat zaken die te maken hebben met algemeen kunstbeleid, de geschreven en audiovisuele pers en de promotie van de nationale cultuur."),
("Sport","Het thema sport omvat enkel zaken die gaan over sportbeleid en beleid tegenover doping."),
("Gezondheid","Het thema gezondheidszorg omvat alle zaken omtrent gezondheidszorg, het ziekenhuiswezen, psychiatrie, terugbetaling medicijnen, tabakswaren, alcohol en drugs en volksgezondheid."),
("Landbouw"," Het thema Landbouw omvat zaken die gaan over landbouw, visserij en voedselkwaliteit."),
("Arbeid","Het thema arbeid omvat zaken die gaan over arbeidsveiligheid, vakbonden, pensioenen en de activering van werklozen."),
("Onderwijs","Het thema onderwijs omvat zaken die te maken hebben met het onderwijsbeleid, hoger onderwijs, basisonderwijs en secundair onderwijs, leraren en onderzoek binnen onderwijs."),
("Milieu","Het thema milieu omvat alle zaken omtrent algemeen milieubeleid, afval, luchtvervuiling, dierenwelzijn en klimaat."),
("Energie","Het thema energie omvat zaken omtrent energiebeleid, kernenergie, hernieuwbare energiebronnen, energievoorziening en energiebesparing."),
("Migratie","Het thema migratie omvat zaken die gaan over integratie, vluchtelingen en asielzoekers, naturalisatie en burgerschap.");

-- Populate the dossiers table

INSERT INTO dossiers(name, info) VALUES
("Brexit",""),
("Marrakesh-pact",""),
("Klimaatprotest",""),
("Kilometerheffing",""),
("Salariswagen","");

-- Populate the parties table

INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"CD&V","Christen-Democratisch en Vlaams",50000,"Christen-Democratisch en Vlaams (afgekort als CD&V) is een Vlaamse, christendemocratische centrumpartij die met ongeveer 20% van de kiezers de tweede grootste partij van Vlaanderen is.","@cdenv",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"cdH",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"CSP",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"DéFI",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"Ecolo",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"Ecolo-Groen",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"FDF",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"Groen","Groen",10000,"Groen is een Vlaamse, progressieve en groene politieke partij, die 10.000 leden telt (2018).","@groen",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"MR",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"N-VA","Nieuw-Vlaamse Alliantie",40000,"De Nieuw-Vlaamse Alliantie, afgekort als N-VA, is een Vlaams-nationalistische en liberaal-conservatieve politieke partij met eind 2014 meer dan 41.000 leden.","@de_NVA",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"Onafhankelijke",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"Open VLD","Open Vlaamse Liberalen en Democraten",63000,"Open Vlaamse Liberalen en Democraten, afgekort als Open Vld, is een Vlaamse liberale politieke partij en is lid van de Alliantie van Liberalen en Democraten voor Europa (ALDE).","@openvld",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"PP",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"PS",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"PTB",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"PTB-GO!",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"PTB-PVDA-go!",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"PVDA","Partij van de Arbeid",15000,"De Partij van de Arbeid van België (PVDA), in het Frans Parti du Travail de Belgique (PTB), is een marxistische politieke partij in België die ijvert voor een socialistische maatschappij.","@pvdabelgie",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"sp.a","Socialistische Partij Anders",49000,"Socialistische Partij Anders, afgekort als sp.a, is een Vlaamse sociaaldemocratische politieke partij die eind 2014 49.703 leden telde.","@sp_a",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"UF",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"VB",NULL,0,NULL,NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"Vlaams Belang","Vlaams Belang",17000,"Vlaams Belang (vaak afgekort als VB) is Belgische politieke partij. De partij is Vlaams-nationalistisch en rechts-conservatief, en staat onder meer bekend voor haar streven naar een onafhankelijk Vlaanderen, de tegenstand met betrekking tot immigratie door personen die zich volgens de partij weigerachtig opstellen tegen integratie of assimilatie naar westerse normen, de verdediging van de traditionele normen en waarden, en het verzet tegen het oprukken in Europa van de politieke islam en het mos","@vlbelang",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_parties(id,pol_id,short_name,full_name,no_of_members,info,twitter,facebook) VALUES (NULL, LAST_INSERT_ID(),"Vuye&Wouters",NULL,0,NULL,NULL,NULL);

-- Populate the person table
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Abdallah","Kanfaoui","Abdallah Kanfaoui",9,"Lid van het Brussels parlement","@kanfaouia","/abdallah.kanfaoui");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ahmed","El Khannouss","Ahmed El Khannouss",2,"Lid van het Brussels parlement",NULL,"/Ahmed-El-Khannouss-595784837163447");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ahmed","El Ktibi","Ahmed El Ktibi",14,"Lid van het Brussels parlement","@ELKTIBIAhmed","/ahmed.elktibi");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ahmed","Laaouej","Ahmed Laaouej",14,"Lid van de Kamer","@AhmedLaaouej","/alaaouej");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Alain","Courtois","Alain Courtois",9,"Lid van het Brussels parlement","@AlainCourtois","/Alain.Courtois.AC");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Alain","Destexhe","Alain Destexhe",9,"Lid van het Brussels parlement","@Destexhe","/alaindestexhe2");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Alain","Maron","Alain Maron",5,"Lid van het Brussels parlement","@alainmaron","/alainmaron");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Alain","Mathot","Alain Mathot",14,"Lid van de Kamer",NULL,"/Alain-Mathot-104839259557352/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Alain","Onkelinx","Alain Onkelinx",14,"Lid van het parlement Waals gewest","@alainonkelinx","/Alain-Onkelinx-425844334226052");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Alain","Top","Alain Top",19,"Lid van de Kamer","@alain_top","/alain.top");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Alda","Greoli","Alda Greoli",2,"lid van de regering Federatie Wallonië-Brussel","@AldaGreoli",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Aldo","Carcaci","Aldo Carcaci",13,"Lid van de Kamer",NULL,"/aldocarcaciofficiel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Alexander","De Croo","Alexander De Croo",12,"Vice-eersteminister en minister van Ontwikkelingssamenwerking, Digitale Agenda, Telecommunicatie en Post","@alexanderdecroo","/alexanderdecroo");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Amet","Gjanaj","Amet Gjanaj",14,"Lid van het Brussels parlement","@AmetGjanaj","/Amet-Gjanaj-PS-1557378837739232");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"An","Capoen","An Capoen",10,"Lid van de Kamer",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"An","Christiaens","An Christiaens",1,"Lid van het Vlaams parlement","@AnTongeren","/an.christiaens.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"An","Moerenhout","An Moerenhout",8,"Lid van het Vlaams parlement","@anmoerenhout","/moerenhoutan");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"André","Antoine","André Antoine",2,"Lid van het parlement Waals gewest","@Andre_Antoine","/andre.antoine");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"André","du Busde Warnaffe","André du Busde Warnaffe",2,"Lid van het Brussels parlement","@andredubus","/André-du-Bus-136723766524824");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"André","Flahaut","André Flahaut",14,"lid van de regering Federatie Wallonië-Brussel","@andreflahaut","/blogflahaut");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"André","Frédéric","André Frédéric",14,"Lid van de Kamer",NULL,"/andre.frederic.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"André","Gantman","André Gantman",10,"Antwerps gemeenteraadslid","@Andre_Gantman","/André-Gantman-706694489351772");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"André-Pierre","Puget","André-Pierre Puget",13,"Lid van het parlement Waals gewest","@AP_Puget","/andrepierrepuget");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Andries","Gryffroy","Andries Gryffroy",10,"Lid van het Vlaams parlement","@gryffroy","/andriesgryffroy");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Anke","Van dermeersch","Anke Van dermeersch",22,"Lid van het Vlaams parlement","@Anke_online","/pages/Anke-Van-Dermeersch/240191162725859");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ann","Brusseel","Ann Brusseel",12,"Lid van het Vlaams parlement","@AnnBrusseel","/ann.brusseel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ann","Soete","Ann Soete",11,"Lid van het Vlaams parlement","@AnnSoete","/ann.minnesoete");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ann","Vanheste","Ann Vanheste",19,"Lid van de Kamer","@AnnVanheste","/profile.php?id=100009986538108");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Anne","Charlotte d'Ursel","Anne Charlotte d'Ursel",9,"Lid van het Brussels parlement",NULL,"/annecharlotte.dursel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Anne","Dedry","Anne Dedry",6,"Lid van de Kamer","@annededry","/annededry");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Anne","Lambelin","Anne Lambelin",14,"Lid van het parlement Waals gewest","@LambelinAnne","/Anne.Lambelin2");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Anneleen","Van Bossuyt","Anneleen Van Bossuyt",10,"Lid van het Europees parlement","@anneleen_vb","/Anneleen-Van-Bossuyt-1375436739430055");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Annemie","Maes","Annemie Maes",8,"Lid van het Brussels parlement","@annemiemaes46","/annemie.maes.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Annemie","Turtelboom","Annemie Turtelboom",12,"Lid van de Kamer","@ATurtelboom","/Annemie-Turtelboom-23567195147/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Annick","De Ridder","Annick De Ridder",10,"Lid van het Vlaams parlement","@AnnickDeRidder","/annick.deridder.10");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Annick","Lambrecht","Annick Lambrecht",19,"Lid van de Kamer","@LambrechtAnnick","/annick.lambrecht");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Anthony","Dufrane","Anthony Dufrane",14,"Lid van het parlement Waals gewest","@AnthonyDufrane","/Anthonydufranedufrane");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Armand","De Decker","Armand De Decker",9,"Lid van het Brussels parlement","@Armanddedecker","/armand.dedecker.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Arnaud","Pinxteren","Arnaud Pinxteren",5,"Lid van het Brussels parlement","@pinxterenarnaud","/arnaud.pinxteren");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Arnaud","Verstraete","Arnaud Verstraete",8,"Lid van het Brussels parlement","@ArnauVerstraete","/arnaud.verstraete.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Axel","Polis","Axel Polis",12,"Antwerps gemeenteraadslid","@axelpolis","/axel.polis");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Axel","Ronse","Axel Ronse",10,"Lid van het Vlaams parlement","@axelronse","/axelronse");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Barbara","Pas","Barbara Pas",21,"Lid van de Kamer","@Barbara_Pas","/BarbaraPasVB");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Barbara","Trachte","Barbara Trachte",5,"Lid van het Brussels parlement","@barbaratrachte","/barbara.trachte");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bart","Caron","Bart Caron",8,"Lid van het Vlaams parlement","@BartCaron","/bartcaron");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bart","De Wever","Bart De Wever",10,"Partijvoorzitter en Burgemeester van Antwerpen","@Bart_DeWever",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bart","Dochy","Bart Dochy",1,"Lid van het Vlaams parlement","@BartDochy","/dochybart");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bart","Nevens","Bart Nevens",10,"Lid van het Vlaams parlement","@BartNevens","/bart.nevens.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bart","Somers","Bart Somers",12,"Lid van het Vlaams parlement","@BartSomers","/bart.somers1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bart","Staes","Bart Staes",8,"Lid van het Europees parlement","@BartStaes","/EuropeesParlementslidGroen.Bart.Staes");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bart","Tommelein","Bart Tommelein",12,"Viceminister-president en Vlaams minister van Begroting, Financiën en Energie","@Barttommelein","/barttommelein");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bart","Van Malderen","Bart Van Malderen",19,"Lid van het Vlaams parlement","@bartvanmalderen","/bartvanmalderen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bea","Diallo","Bea Diallo",14,"Lid van het Brussels parlement","@BeaDiallo","/BeaDialloOfficiel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ben","Weyts","Ben Weyts",10,"Vlaams Minister van Mobiliteit, Openbare Werken, Vlaamse rand, Toerisme en Dierenwelzijn","@BenWeyts","/weytsben");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Benoit","Cerexhe","Benoit Cerexhe",2,"Lid van het Brussels parlement","@Cerexhe","/Benoît-Cerexhe-411071712317033");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Benoît","Dispa","Benoît Dispa",2,"Lid van de Kamer",NULL,"/dispabenoit");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Benoit","Drèze","Benoit Drèze",2,"Lid van het parlement Waals gewest","@BenoitDreze","/benoit.dreze");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Benoît","Friart","Benoît Friart",9,"Lid van de Kamer","@BenoitFriart","/benoit.friart.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Benoit","Hellings","Benoit Hellings",6,"Lid van de Kamer","@BenoitHellings","/benoithellings");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Benoît","Lutgen","Benoît Lutgen",2,"Lid van de Kamer","@BenoitLutgen",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Benoît","Piedboeuf","Benoît Piedboeuf",9,"Lid van de Kamer","@Benoitbp59","/benoitpiedboeuf59");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bernard","Clerfayt","Bernard Clerfayt",7,"Lid van het Brussels parlement","@clerfay10","/Bernard-Clerfayt-38895484698");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bert","Maertens","Bert Maertens",10,"Lid van het Vlaams parlement","@MaertensBert","/bert.maertens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bert","Moyaers","Bert Moyaers",19,"Lid van het Vlaams parlement","@MoyaersBert","/bert.moyaers.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bert","Wollants","Bert Wollants",10,"Lid van de Kamer","@BertWollants","/wollantsbert");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bertin","Mampaka Mankamba","Bertin Mampaka Mankamba",2,"Lid van het Brussels parlement","@Bmampaka","/senateurMampaka");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Björn","Anseeuw","Björn Anseeuw",10,"Lid van het Vlaams parlement","@bjanseeuw","/bjorn.anseeuw");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Björn","Rzoska","Björn Rzoska",8,"Lid van het Vlaams parlement","@BjornRzoska","/bjorn.rzoska");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Boris","Dillies","Boris Dillies",9,"Lid van het Brussels parlement","@BorisDillies","/boris.dillies");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Brecht","Vermeulen","Brecht Vermeulen",10,"Lid van de Kamer","@VermeulenBrecht","/brecht.vermeulen.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Brigitte","Grouwels","Brigitte Grouwels",1,"Lid van het Brussels parlement","@BGrouwels","/brigitte.grouwels");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bruno","De Lille","Bruno De Lille",8,"Lid van het Brussels parlement","@BrunoDeLille","/bruno.delille");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bruno","Lefebvre","Bruno Lefebvre",14,"Lid van het parlement Waals gewest","@Brunolefebvre01","/brunolefebvrefanbook");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bruno","Tobback","Bruno Tobback",19,"Lid van het Vlaams parlement","@brunotobback",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Bruno","Valkeniers","Bruno Valkeniers",22,"Antwerps gemeenteraadslid",NULL,"/bruno.valkeniers");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Carina","Van Cauter","Carina Van Cauter",12,"Lid van de Kamer","@CarinaVanCauter","/CarinaVanCauterOpenVld");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Carine","Lecomte","Carine Lecomte",9,"Lid van het parlement Waals gewest",NULL,"/carine.lecomte.MR");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Carine","Leys","Carine Leys",10,"Antwerps gemeenteraadslid","@Carine_Leys","/carine.leys.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Carla","Dejonghe","Carla Dejonghe",12,"Lid van het Brussels parlement",NULL,"/carla.dejonghe.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Carlo","Di Antonio","Carlo Di Antonio",2,"lid van de regering Federatie Wallonië-Brussel","@CarloDiAntonio","/page.carlodiantonio");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Caroline","Bastiaens","Caroline Bastiaens",1,"Antwerps gemeenteraadslid","@bastiaenscarol","/caroline.bastiaens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Caroline","Cassart-Mailleux","Caroline Cassart-Mailleux",9,"Lid van de Kamer","@CarolineCassart","/caroline.cassart.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Caroline","Desir","Caroline Desir",14,"Lid van het Brussels parlement","@CarolineDesir","/caroline.desir");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Caroline","Gennez","Caroline Gennez",19,"Lid van het Vlaams parlement","@carogennez","/carolinegennez");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Caroline","Persoons","Caroline Persoons",7,"Lid van het Brussels parlement","@CaroPersoons","/Page-de-Caroline-Persoons-députée-échevine-1524180607887722");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Catherine","Fonck","Catherine Fonck",2,"Lid van de Kamer","@catherinefonck","/catherinefonck");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Catherine","Moureaux","Catherine Moureaux",14,"Lid van het Brussels parlement","@catmoureaux","/catherine.moureaux");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Cathy","Coudyser","Cathy Coudyser",10,"Lid van het Vlaams parlement","@CCoudyser","/cathy.coudyser");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Céline","Delforge","Céline Delforge",5,"Lid van het Brussels parlement","@celinedelforge","/cdelforge");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Charles","Gardier","Charles Gardier",9,"Lid van het parlement Waals gewest","@charles_gardier","/gardiercharles");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Charles","Michel","Charles Michel",9,"Eerste minister","@CharlesMichel","/CharlesMichel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Charles","Picqué","Charles Picqué",14,"Lid van het Brussels parlement",NULL,"/charles.picque");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Chris","Janssens","Chris Janssens",22,"Lid van het Vlaams parlement","@chrisjanssensVB","/chris.janssens1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Christian","Brotcorne","Christian Brotcorne",2,"Lid van de Kamer",NULL,"/christian.brotcorne");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Christian","Van Eyken","Christian Van Eyken",20,"Lid van het Vlaams parlement",NULL,"/christian.vaneyken.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Christiane","Vienne","Christiane Vienne",14,"Lid van het parlement Waals gewest","@chvienne","/Christiane-Vienne-1605017949780170");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Christie","Morreale","Christie Morreale",14,"Lid van het parlement Waals gewest","@christiemorreal","/morrealechristie");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Christine","Defraigne","Christine Defraigne",9,"Lid van het parlement Waals gewest","@chrisdefraigne","/chrisdefraigne");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Christine","Poulin","Christine Poulin",14,"Lid van het parlement Waals gewest","@Poulinchristine","/mlksdjdjdchhdwbbvxxdhddjje?ref=br_rs");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Christoph","D'Haese","Christoph D'Haese",10,"Lid van de Kamer",NULL,"/christoph.dhaese");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Christophe","Collignon","Christophe Collignon",14,"Lid van het parlement Waals gewest","@ChristopheHuy","/christophe.collignonbis");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Christos","Doulkeridis","Christos Doulkeridis",5,"Lid van het Brussels parlement","@doulkeridis","/christosdoulkeridis");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Cieltje","Van Achter","Cieltje Van Achter",10,"Lid van het Brussels parlement","@CieltjeVAchter","/cieltje.vanachter");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Cindy","Franssen","Cindy Franssen",1,"Lid van het Vlaams parlement","@FranssenCindy","/cindyfranssen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Claire","Geraets","Claire Geraets",17,"Lid van het Brussels parlement",NULL,"/claire.geraets");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Claude","Marinower","Claude Marinower",12,"Antwerpse schepen bevoegd voor economie, werk, innovatie, industrie, digitalisering, marketing en communicatie, openbaar domein en rechtszaken","@ClaudeMarinower","/marinower");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Claude","Rolin","Claude Rolin",2,"Lid van het Europees parlement","@clauderolin","/PageClaudeRolin");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Corinne","De Permentier","Corinne De Permentier",9,"Lid van het Brussels parlement",NULL,"/CorinneDePermentierFan");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Damien","Thiéry","Damien Thiéry",9,"Lid van de Kamer","@DamienThiery",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Daniel","Bacquelaine","Daniel Bacquelaine",9,"Minister van Pensioenen","@DanBacquelaine","/dbacquelaine");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Daniel","Senesael","Daniel Senesael",14,"Lid van de Kamer","@danielsenesael","/senesaeldaniel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Danielle","Godderis-T'Jonck","Danielle Godderis-T'Jonck",10,"Lid van het Vlaams parlement","@DanielleTJonck","/danielle.godderistjonck");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Danielle","Meirsman","Danielle Meirsman",10,"Antwerps gemeenteraadslid","@d_meirsman",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Daniëlle","Vanwesenbeeck","Daniëlle Vanwesenbeeck",12,"Lid van het Vlaams parlement","@Danielle_VWB","/danielle.vanwesenbeeck");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Danny","Feyen","Danny Feyen",10,"Antwerps gemeenteraadslid","@dannyfeyen","/danny.feyen.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Daphné","Dumery","Daphné Dumery",10,"Lid van de Kamer","@ddumery","/daphne.dumery.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"David","Clarinval","David Clarinval",9,"Lid van de Kamer","@DavidClarinval","/clarinval.david");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"David","Geerts","David Geerts",19,"Lid van de Kamer","@GeertsDavid","/david.geerts.12");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Déborah","Geradon","Déborah Geradon",14,"Lid van het parlement Waals gewest","@geradondeborah","/deborahgeradon");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Denis","Ducarme","Denis Ducarme",9,"Minister van Middenstand, Zelfstandigen, KMO's, Landbouw en Maatschappelijke Integratie","@ducarmedenis","/denisducarmeofficiel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Didier","Reynders","Didier Reynders",9,"Vice-eersteminister en minister van Buitenlandse en Europese Zaken","@dreynders","/Didier-Reynders-66985740526");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Dimitri","Fourny","Dimitri Fourny",2,"Lid van het parlement Waals gewest","@DimitriFourny1","/dimitri.fourny.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Dimitri","Legasse","Dimitri Legasse",14,"Lid van het parlement Waals gewest","@DimitriLEGASSE","/dimitrilegasseps");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Dirk","de Kort","Dirk de Kort",1,"Lid van het Vlaams parlement","@Dirk_de_Kort","/Dirk.deKort.77");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Dirk","Janssens","Dirk Janssens",12,"Lid van de Kamer",NULL,"/dirk.janssens.56");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Dirk","Rochtus","Dirk Rochtus",10,"Antwerps gemeenteraadslid","@DirkRochtus","/dirk.rochtus");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Dirk","Van der Maelen","Dirk Van der Maelen",19,"Lid van de Kamer","@dirkvdmaelen","/dirkvandermaelen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Dirk","Van Mechelen","Dirk Van Mechelen",12,"Lid van de Kamer","@DirkVanMechele1","/dirk.vanmechelen.90");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Dominiek","Lootens-Stael","Dominiek Lootens-Stael",22,"Lid van het Brussels parlement","@DominiekLootens","/lootensstael/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Dominique","Dufourny","Dominique Dufourny",9,"Lid van het Brussels parlement",NULL,"/dominique.dufourny");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Edmund","Stoffels","Edmund Stoffels",14,"Lid van het parlement Waals gewest","@Edmund_Stoffels","/edmund.stoffels.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Egbert","Lachaert","Egbert Lachaert",12,"Lid van de Kamer","@egbertlachaert","/TeamEgbert");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Éliane","Tillieux","Éliane Tillieux",14,"Lid van het parlement Waals gewest","@elianetillieux","/Pstillieux");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Elio","Di Rupo","Elio Di Rupo",14,"Lid van de Kamer","@eliodirupo","/elio.dirupo");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Elisabeth","Meuleman","Elisabeth Meuleman",8,"Lid van het Vlaams parlement","@Elisameuleman","/elisabeth.meuleman.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Elke","Sleurs","Elke Sleurs",10,"Lid van het Vlaams parlement","@ElkeSleurs","/elkesleurs.nva");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Elke","Van den Brandt","Elke Van den Brandt",8,"Lid van het Vlaams parlement","@elkevdbrandt","/elke.vandenbrandt.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Els","Ampe","Els Ampe",12,"Lid van het Brussels parlement","@ElsAmpe","/els.ampe.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Els","Robeyns","Els Robeyns",19,"Lid van het Vlaams parlement","@elsrobeyns","/erobeyns");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Els","Van Hoof","Els Van Hoof",1,"Lid van de Kamer","@ElsVanHoofcdenv","/vanhoofels");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Emin","Özkara","Emin Özkara",14,"Lid van het Brussels parlement",NULL,"/emin.ozkara.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Emir","Kir","Emir Kir",14,"Lid van de Kamer","@emir_kir","/emirkir");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Emmanuel","Burton","Emmanuel Burton",9,"Lid van de Kamer",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Emmanuel","De Bock","Emmanuel De Bock",7,"Lid van het Brussels parlement","@ManuDeBock","/Ensemblechangeonsbruxelles");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Emmily","Talpe","Emmily Talpe",12,"Lid van het Vlaams parlement","@emmilytalpe","/talpe");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Eric","Bott","Eric Bott",7,"Lid van het Brussels parlement","@ericbott1200","/ericbott1200");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Eric","Massin","Eric Massin",14,"Lid van de Kamer","@EricMassin","/eric.massin.charleroi");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Eric","Thiébaut","Eric Thiébaut",14,"Lid van de Kamer","@EricThiebaut",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Eric","Van Rompuy","Eric Van Rompuy",1,"Lid van de Kamer",NULL,"/ericvanrompuy");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Evelyne","Huytebroeck","Evelyne Huytebroeck",5,"Lid van het Brussels parlement","@Ehuytebroeck","/evelyne.huytebroeck");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Evita","Willaert","Evita Willaert",6,"Lid van de Kamer","@EvitaWillaert","/evita.willaert");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fabian","Culot","Fabian Culot",9,"Lid van het parlement Waals gewest","@FCulot","/fabian.culot.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fabian","Maingain","Fabian Maingain",7,"Lid van het Brussels parlement","@MaingainFabian","/maingainfabian");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fabienne","Winckel","Fabienne Winckel",14,"Lid van de Kamer","@FabienneWinckel","/Fabienne-Winckel-218743671488942");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fatima","Talhaoui","Fatima Talhaoui",10,"Antwerps gemeenteraadslid","@fat40talhaoui","/fatima.talhaoui.984");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fatma","Akbas","Fatma Akbas",19,"Antwerps gemeenteraadslid",NULL,"/fatma.akbas.391?ref=br_rs");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fatma","Pehlivan","Fatma Pehlivan",19,"Lid van de Kamer","@pehlivan_fatma",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fatoumata","Sidibé","Fatoumata Sidibé",7,"Lid van het Brussels parlement","@fatoumatafathy","/Fatoumata-Sidibé-DéFI-197302430466472");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fauzaya","Talhaoui","Fauzaya Talhaoui",19,"Antwerps gemeenteraadslid","@Fauzaya","/fauzaya.talhaoui");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Filip","Dewinter","Filip Dewinter",21,"Lid van de Kamer","@FDW_VB","/fdwvb");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Filip","Dewinter","Filip Dewinter",22,"Lid van de Kamer","@FDW_VB","/fdwvb");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fons","Duchateau","Fons Duchateau",10,"Voorzitter van AG VESPA, Antwerpse schepen bevoegd voor wonen, patrimonium, groen, dierenwelzijn, stads- en buurtonderhoud, en gezondheids- en seniorenzorg","@DuchateauFons","/DuchateauFons");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Fouad","Ahidar","Fouad Ahidar",19,"Lid van het Brussels parlement","@Fouad_Ahidar","/fouad.ahidar");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Francesco","Vanderjeugd","Francesco Vanderjeugd",12,"Lid van het Vlaams parlement","@FrancescoFV","/pages/Francesco-Vanderjeugd/120297387997116");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Francis","Delpérée","Francis Delpérée",2,"Lid van de Kamer",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"François","Bellot","François Bellot",9,"Minister van Mobiliteit","@francois_bellot","/BellotFrancois");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"François","Desquesnes","François Desquesnes",2,"Lid van het parlement Waals gewest","@DESQUESNESF","/f.desquesnes");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Françoise","Bertieaux","Françoise Bertieaux",9,"Lid van het Brussels parlement","@BertieauxF","/FrancoiseBertieaux");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Françoise","Schepmans","Françoise Schepmans",9,"Lid van de Kamer","@fschepmans","/schepmansfrancoise");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Franky","Demon","Franky Demon",1,"Lid van de Kamer","@FrankyDemon","/demonfranky");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Franky","Loveniers","Franky Loveniers",10,"Antwerps gemeenteraadslid","@FrankyLoveniers","/franky.loveniers");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Frédéric","Daerden","Frédéric Daerden",14,"Lid van de Kamer","@FredericDaerden","/frederic.daerden.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Frédéric","Gillot","Frédéric Gillot",15,"Lid van het parlement Waals gewest",NULL,"/gillot.f");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Frédérique","Ries","Frédérique Ries",9,"Lid van het Europees parlement","@Frederiqueries","/frederiqueries2");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Freya","Piryns","Freya Piryns",8,"Antwerps gemeenteraadslid","@FreyaPiryns","/freyapiryns");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Freya","Saeys","Freya Saeys",12,"Lid van het Vlaams parlement","@FreyaSaeys","/freya.saeys");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Freya","Van den Bossche","Freya Van den Bossche",19,"Lid van het Vlaams parlement","@freyabos","/freyavandenbossche");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Gaëtan","Van Goidsenhoven","Gaëtan Van Goidsenhoven",9,"Lid van het Brussels parlement",NULL,"/gaetan.vangoidsenhoven.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Galina","Matushina","Galina Matushina",1,"Antwerps gemeenteraadslid","@GalinaMatushina","/galina.matushina");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Gautier","Calomne","Gautier Calomne",9,"Lid van de Kamer","@GautierCalomne","/CalomneGautier");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Geert","Bourgeois","Geert Bourgeois",10,"Vlaams minister-president","@GeertBourgeois","/GeertBourgeois.vl");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Georges","Dallemagne","Georges Dallemagne",2,"Lid van de Kamer","@G_Dallemagne","/georges.dallemagne");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Georges","Gilkinet","Georges Gilkinet",6,"Lid van de Kamer","@GeorgesGilkinet","/georges.gilkinet");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Gérard","Deprez","Gérard Deprez",9,"Lid van het Europees parlement","@gerardeprez","/gerardeprez");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Gerolf","Annemans","Gerolf Annemans",22,"Lid van het Europees parlement","@gannemans","/gannemans");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Gilles","Foret","Gilles Foret",9,"Lid van de Kamer","@gillesforet","/PageGillesForet");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Gilles","Mouyard","Gilles Mouyard",9,"Lid van het parlement Waals gewest","@GillesMouyard","/gilles.mouyard");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Gilles","Vanden Burre","Gilles Vanden Burre",6,"Lid van de Kamer","@Gilles_VDB","/gilles.burre");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Goedele","Uyttersprot","Goedele Uyttersprot",10,"Lid van de Kamer","@G_Uyttersprot","/goedele.uyttersprot");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Graziana","Trotta","Graziana Trotta",14,"Lid van het parlement Waals gewest","@GrazianaTrotta","/graziana.trotta.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Greet","van Gool","Greet van Gool",19,"Antwerps gemeenteraadslid",NULL,"/greet.vangool");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Grete","Remen","Grete Remen",10,"Lid van het Vlaams parlement","@GreteRemen","/grete.remen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Griet","Coppé","Griet Coppé",1,"Lid van het Vlaams parlement","@GrietCoppe","/griet.coppe");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Griet","Smaers","Griet Smaers",1,"Lid van de Kamer","@grietsmaers","/griet.smaers");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Güler","Turan","Güler Turan",19,"Lid van het Vlaams parlement","@Turan_Guler","/guler.turan.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Guy","D'haeseleer","Guy D'haeseleer",22,"Lid van het Vlaams parlement","@GuydhaeseleerVB","/guy.dhaeseleer.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Guy","Verhofstadt","Guy Verhofstadt",12,"Lid van het Europees parlement","@GuyVerhofstadt","/GuyVerhofstadt");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Gwenaëlle","Grovonius","Gwenaëlle Grovonius",14,"Lid van de Kamer","@Gwengrovonius","/gwenaelle.grovonius");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Gwenny","De Vroe","Gwenny De Vroe",12,"Lid van het Vlaams parlement","@Gwenny_De_Vroe","/pages/Gwenny-De-Vroe/84315622940");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hamza","Fassi-Fihri","Hamza Fassi-Fihri",2,"Lid van het Brussels parlement","@hamzafassi","/hamzafassiofficiel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hannelore","Goeman","Hannelore Goeman",19,"Lid van het Brussels parlement","@HanneloreGoeman","/hannelore.goeman");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hans","Bonte","Hans Bonte",19,"Lid van de Kamer",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hasan","Koyuncu","Hasan Koyuncu",14,"Lid van het Brussels parlement","@HasanKoyuncu_PS","/hasan.koyuncu.963");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hélène","Ryckmans","Hélène Ryckmans",5,"Lid van het parlement Waals gewest","@HeleneRyckmans","/HeleneRyckmansEcolo");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Helga","Stevens","Helga Stevens",10,"Lid van het Europees parlement","@StevensHelga","/HelgastevensNVA");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hendrik","Bogaert","Hendrik Bogaert",1,"Lid van de Kamer","@hendrikbogaert","/bogaerthendrik");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hendrik","Vuye","Hendrik Vuye",23,"Lid van de Kamer","@HendrikVuye",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Herman","De Croo","Herman De Croo",12,"Lid van het Vlaams parlement","@hermandecroo","/herman.decroo.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Herman","Wynants","Herman Wynants",10,"Lid van het Vlaams parlement",NULL,"/herman.wijnants.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hermes","Sanctorum-Vandevoorde","Hermes Sanctorum-Vandevoorde",11,"Lid van het Vlaams parlement","@hermessanctorum","/hermes.sanctorum");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hilde","Crevits","Hilde Crevits",1,"Viceminister-president en Vlaams minister van Onderwijs","@crevits","/hilde.crevits");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hilde","Vautmans","Hilde Vautmans",12,"Lid van het Europees parlement","@hildevautmans","/Hvautmans");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Hugues","Bayet","Hugues Bayet",14,"Lid van het Europees parlement","@HuguesBayet","/hbayet");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ikrame","Kastit","Ikrame Kastit",8,"Antwerps gemeenteraadslid","@IkrameKastit","/ikrame.kastitvervolg.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Imade","Annouri","Imade Annouri",8,"Lid van het Vlaams parlement","@ImadeAnnouri","/imade.annouri");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ine","Somers","Ine Somers",12,"Lid van de Kamer","@IneSomers","/ine.somers.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Inez","De Coninck","Inez De Coninck",10,"Lid van de Kamer","@inez_deconinck","/Inez-De-Coninck-217614291773059");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ingeborg","De Meulemeester","Ingeborg De Meulemeester",10,"Lid van het Vlaams parlement",NULL,"/ingeborg.demeulemeester");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ingrid","Pira","Ingrid Pira",8,"Lid van het Vlaams parlement","@IngridPira1","/ingrid.pira");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Isabelle","Emmery","Isabelle Emmery",14,"Lid van het Brussels parlement","@Isabellemmery","/isabelle.emmery");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Isabelle","Galant","Isabelle Galant",9,"Lid van de Kamer",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Isabelle","Moinnet-Joiret","Isabelle Moinnet-Joiret",2,"Lid van het parlement Waals gewest","@IsabelleMoinnet","/isabelle.joiret");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Isabelle","Poncelet","Isabelle Poncelet",2,"Lid van de Kamer",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Isabelle","Simonis","Isabelle Simonis",14,"lid van de regering Federatie Wallonië-Brussel","@SimonisIsa","/isabellesimonis");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Isabelle","Stommen","Isabelle Stommen",2,"Lid van het parlement Waals gewest",NULL,"/isabelle.stommen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ivo","Belet","Ivo Belet",1,"Lid van het Europees parlement","@IvoBelet","/Ivo-Belet-1506612632980641/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jacqueline","Galant","Jacqueline Galant",9,"Lid van het parlement Waals gewest","@jgalant74","/jacqueline.galant");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jacqueline","Rousseaux","Jacqueline Rousseaux",9,"Lid van het Brussels parlement",NULL,"/jacqueline.rousseaux");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jacques","Brotchi","Jacques Brotchi",9,"Lid van het Brussels parlement","@brotchi","/brotchi.be");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jamal","Ikazban","Jamal Ikazban",14,"Lid van het Brussels parlement","@ikazban","/Jamal-Ikazban-1584980545091433");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jan","Bertels","Jan Bertels",19,"Lid van het Vlaams parlement","@jan_bertels","/janbertels.98");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jan","Durnez","Jan Durnez",1,"Lid van het Vlaams parlement","@JanDurnez","/durnezjan");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jan","Jambon","Jan Jambon",10,"Vice-eersteminister en minister van Veiligheid en Binnenlandse Zaken","@JanJambon","/JanJambonNVA");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jan","Penris","Jan Penris",21,"Lid van de Kamer","@JanPenris","/Jan-Penris-259474764222822/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jan","Peumans","Jan Peumans",10,"Lid van het Vlaams parlement",NULL,"/peumansjan");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jan","Spooren","Jan Spooren",10,"Lid van de Kamer","@SpoorenJan","/burgemeestervantervuren");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jan","Van Esbroeck","Jan Van Esbroeck",10,"Lid van het Vlaams parlement","@JanVanEsbroeck","/jan.vanesbroeck");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jan","Vercammen","Jan Vercammen",10,"Lid van de Kamer","@JanVercammenNVA",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean","Goedtkindt","Jean Goedtkindt",10,"Antwerps gemeenteraadslid",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Charles","Luperto","Jean-Charles Luperto",14,"Lid van het parlement Waals gewest","@jcluperto","/Jean-Charles-Luperto-358747947485304");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Claude","Marcourt","Jean-Claude Marcourt",14,"lid van de regering Federatie Wallonië-Brussel","@jcmarcourt","/JCMarcourtOfficiel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Jacques","De Gucht","Jean-Jacques De Gucht",12,"Lid van het Vlaams parlement",NULL,"/pages/Jean-Jacques-De-Gucht/66486310616");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Jacques","Flahaux","Jean-Jacques Flahaux",9,"Lid van de Kamer","@FlahauxMRI","/JJFlahaux");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Luc","Crucke","Jean-Luc Crucke",9,"lid van de regering Federatie Wallonië-Brussel","@cruckejeanluc","/Jean-Luc-Crucke-63026042352");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Marc","Delizée","Jean-Marc Delizée",14,"Lid van de Kamer","@jmdelizee","/jeanmarc.delizee");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Marc","Dupont","Jean-Marc Dupont",14,"Lid van het parlement Waals gewest",NULL,"/PS.JeanMarcDupont");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Marc","Nollet","Jean-Marc Nollet",6,"Lid van de Kamer","@jmnollet","/Jean-Marc-Nollet-264133970699746/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Paul","Wahl","Jean-Paul Wahl",9,"Lid van het parlement Waals gewest","@JeanPaulWahl","/Jean-Paul-Wahl-152991231958625/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jean-Pierre","Denis","Jean-Pierre Denis",14,"Lid van het parlement Waals gewest","@JPierreDenis","/JeanPierreDenisPS");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jef","Van Damme","Jef Van Damme",19,"Lid van het Brussels parlement","@Jefvandamme","/jef.vandamme.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jef","Van den Bergh","Jef Van den Bergh",1,"Lid van de Kamer","@jefvandenbergh","/vandenberghjef");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jelle","Engelbosch","Jelle Engelbosch",10,"Lid van het Vlaams parlement","@JelleEngelbosch","/jelle.engelbosch");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jenne","De Potter","Jenne De Potter",1,"Lid van het Vlaams parlement","@JenneDePotter","/jenne.depotter");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jenny","Baltus-Möres","Jenny Baltus-Möres",9,"Lid van het parlement Waals gewest","@JennyBaltus","/Jenny-Baltus-Möres-775841732454846");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jo","De Ro","Jo De Ro",12,"Lid van het Vlaams parlement","@jo_dero","/jo.dero.31");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jo","Vandeurzen","Jo Vandeurzen",1,"Vlaams Minister van Welzijn, Volksgezondheid en gezin","@JoVandeurzen","/vandeurzenjo");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Joëlle","Kapompolé","Joëlle Kapompolé",14,"Lid van het parlement Waals gewest","@Kapompole","/kapompole");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Joëlle","Maison","Joëlle Maison",7,"Lid van het Brussels parlement","@JoelleMaison","/JoelleMaisonUccle");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Joëlle","Milquet","Joëlle Milquet",2,"Lid van het Brussels parlement","@JoelleMilquet","/joelle.milquetpage");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Johan","Danen","Johan Danen",8,"Lid van het Vlaams parlement","@JohanDanen","/johan.danen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Johan","Klaps","Johan Klaps",10,"Antwerps gemeenteraadslid","@JJohanKlaps","/johan.klaps");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Johan","Klaps","Johan Klaps",10,"Lid van de Kamer","@JohanKlaps","/johan.klaps");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Johan","Van den Driessche","Johan Van den Driessche",10,"Lid van het Brussels parlement","@jvddriessche","/johan.vandendriessche.52");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Johan","Van Overtveldt","Johan Van Overtveldt",10,"Minister van Financiën en Bestrijding van fiscale fraude","@jvanovertveldt","/johanvanovertveldt");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Johan","Verstreken","Johan Verstreken",1,"Lid van het Vlaams parlement","@JohanVerstreken","/pages/Johan-Verstreken-Vriendenpagina-127151154015789");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Joke","Schauvliege","Joke Schauvliege",1,"Vlaams Minister van Omgeving, Natuur en Landbouw","@JokeSchauvliege","/joke.schauvliege");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jordan","Godfriaux","Jordan Godfriaux",9,"Lid van het parlement Waals gewest","@jordangodfriaux","/jordangodfriauxperwez");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Joris","Giebens","Joris Giebens",8,"Antwerps gemeenteraadslid",NULL,"/joris.giebens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Joris","Poschet","Joris Poschet",1,"Lid van het Vlaams parlement","@JorisPoschet","/joris.poschet");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Joris","Vandenbroucke","Joris Vandenbroucke",19,"Lid van het Vlaams parlement","@JorisVDBroucke","/jorisvandenbroucke");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jos","De Meyer","Jos De Meyer",1,"Lid van het Vlaams parlement","@JosDeMeyer","/jos.demeyer.545");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Jos","Lantmeeters","Jos Lantmeeters",10,"Lid van het Vlaams parlement","@joslantmeeters","/joslantmeeters");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Josy","Arens","Josy Arens",2,"Lid van het parlement Waals gewest",NULL,"/josy.arens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Julie","De Groote","Julie De Groote",2,"Lid van het Brussels parlement","@Julie_deGroote","/julie.degroote.73");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Julie","Fernandez Fernandez","Julie Fernandez Fernandez",14,"Lid van de Kamer","@JulieFFernandez","/JulieFernandezFernandez");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Julien","Uyttendaele","Julien Uyttendaele",14,"Lid van het Brussels parlement","@Juuyttendaele","/uyttendaele.brussels");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Karim","Bachar","Karim Bachar",19,"Antwerps gemeenteraadslid","@BacharKarim","/karim.bachar.8");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Karim","Van Overmeire","Karim Van Overmeire",10,"Lid van het Vlaams parlement","@KVanOvermeire","/karim.vanovermeire");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Karin","Brouwers","Karin Brouwers",1,"Lid van het Vlaams parlement","@BrouwersKarin","/karin.brouwers.33");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Karin","Jiroflée","Karin Jiroflée",19,"Lid van de Kamer","@KarinJiroflee","/karin.jiroflee");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Karin","Temmerman","Karin Temmerman",19,"Lid van de Kamer","@karintemmerman","/karintemmerman");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Karine","Lalieux","Karine Lalieux",14,"Lid van de Kamer","@karinelalieux","/LalieuxKarine");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Karl","Vanlouwe","Karl Vanlouwe",10,"Lid van het Vlaams parlement","@KarlVanlouwe","/karlvanlouwe");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Karolien","Grosemans","Karolien Grosemans",10,"Lid van de Kamer","@KaroGrosemans","/karolien.grosemans");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kathleen","Helsen","Kathleen Helsen",1,"Lid van het Vlaams parlement","@KathleenHelsen","/kathleen.helsen.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kathleen","Krekels","Kathleen Krekels",10,"Lid van het Vlaams parlement","@KathleenKrekels","/kathleen.krekels");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kathleen","Van Brempt","Kathleen Van Brempt",19,"Lid van het Europees parlement","@kvanbrempt","/kathleenvanbrempt");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kathy","Kimpe","Kathy Kimpe",10,"Antwerps gemeenteraadslid","@KathyKimpe","/kathy.kimpe");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Katia","Segers","Katia Segers",19,"Lid van het Vlaams parlement","@katiasegers","/katia.segers");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Katja","Gabriëls","Katja Gabriëls",12,"Lid van de Kamer","@katja_gabriels","/katja.gabriels.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Katrien","Partyka","Katrien Partyka",1,"Lid van het Vlaams parlement","@katparty","/katrien.partyka");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Katrien","Schryvers","Katrien Schryvers",1,"Lid van het Vlaams parlement","@KatrienSchryver","/katrien.schryvers");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kattrin","Jadin","Kattrin Jadin",9,"Lid van de Kamer","@KattrinJadin","/kattrin.jadin");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kenza","Yacoubi","Kenza Yacoubi",14,"Lid van het Brussels parlement","@KenzaYacoubi","/Yacoubikenza");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kevin","Vereecken","Kevin Vereecken",10,"Antwerps gemeenteraadslid","@KevinVereecken","/vereecken1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Khadija","Zamouri","Khadija Zamouri",12,"Lid van het Brussels parlement","@KhadijaZamouri","/khadija.zamouri.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Koen","Daniëls","Koen Daniëls",10,"Lid van het Vlaams parlement","@koendaniels","/koendaniels");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Koen","Geens","Koen Geens",1,"Minister van Justitie","@Koen_Geens1","/KoenGeensCDenV");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Koen","Kennis","Koen Kennis",10,"Antwerpse schepen bevoegd voor financiën, mobiliteit, toerisme, middenstand en decentralisatie","@Koen_Kennis","/koen.kennis.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Koen","Laenens","Koen Laenens",10,"Antwerps gemeenteraadslid","@Koen_Laenens","/klaenens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Koen","Metsu","Koen Metsu",10,"Lid van de Kamer","@MetsuKoen","/koenmetsublogt");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Koen","Van den Heuvel","Koen Van den Heuvel",1,"Lid van het Vlaams parlement","@KVDHeuvel_VP","/koen.vandenheuvel.1291");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Koenraad","Degroote","Koenraad Degroote",10,"Lid van de Kamer","@koenraaddegroo1","/koenraad.degroote.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kris","Peeters","Kris Peeters",1,"Vice-eersteminister en minister van Werk, Economie en Consumenten","@peeters_kris1","/kris.peeters1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kris","Van Dijck","Kris Van Dijck",10,"Lid van het Vlaams parlement","@KrisVanDijck1","/kris.vandijck.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kristien","Van Vaerenbergh","Kristien Van Vaerenbergh",10,"Lid van de Kamer",NULL,"/kristienvanvaerenbergh");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kristof","Calvo","Kristof Calvo",6,"Lid van de Kamer","@kristofcalvo","/kristofcalvo");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Kurt","De Loor","Kurt De Loor",19,"Lid van het Vlaams parlement","@kurtdeloor","/kurt.deloor");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Laetitia","Brogniez","Laetitia Brogniez",9,"Lid van het parlement Waals gewest",NULL,"/Lbrogniez");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Latifa","Gahouchi","Latifa Gahouchi",14,"Lid van het parlement Waals gewest","@LatifaGahouchi","/latigahouchi");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Laurent","Devin","Laurent Devin",14,"Lid van de Kamer",NULL,"/Laurent-Devin-336120296434622");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Laurent","Henquet","Laurent Henquet",9,"Lid van het parlement Waals gewest","@HenquetLaurent","/lhenquet");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Laurette","Onkelinx","Laurette Onkelinx",14,"Lid van de Kamer","@LOnkelinx","/laurette.onkelinx/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Leen","Dierick","Leen Dierick",1,"Lid van de Kamer","@leendierick","/leen.dierick");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Leyla","Aydemir","Leyla Aydemir",10,"Antwerps gemeenteraadslid","@AydemirLeyla","/leyla.aydemir.12");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Lies","Jans","Lies Jans",10,"Lid van het Vlaams parlement","@lies_jans","/lies.jans.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Liesbet","Dhaene","Liesbet Dhaene",10,"Lid van het Brussels parlement","@LiesbetDhaene","/liesbet.dhaene");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Liesbeth","Homans","Liesbeth Homans",10,"Viceminister-president en Vlaams minister van Binnenlands bestuur, Inburgering, Wonen, Gelijke kansen en Armoedebestrijding","@LiesbethHomans","/homansliesbeth");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Lieve","Maes","Lieve Maes",10,"Lid van het Vlaams parlement",NULL,"/lieve.maes.71");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Lieve","Wierinck","Lieve Wierinck",12,"Lid van het Europees parlement","@LieveWierinck","/lievewierinckMEP");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Lionel","Bajart","Lionel Bajart",12,"Lid van het Vlaams parlement","@LionelBajart","/lionel.bajart");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Lisa","Geets","Lisa Geets",10,"Antwerps gemeenteraadslid","@lisa_geets","/lisageets1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Lode","Ceyssens","Lode Ceyssens",1,"Lid van het Vlaams parlement","@LodeCeyssens","/lodeceyssens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Lorin","Parys","Lorin Parys",10,"Lid van het Vlaams parlement","@lorinparys","/lorinparys");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Louis","Michel","Louis Michel",9,"Lid van het Europees parlement","@LouisMichel","/page.louis.michel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Luc","Gustin","Luc Gustin",9,"Lid van de Kamer",NULL,"/luc.gustin.94");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ludo","Van Campenhout","Ludo Van Campenhout",10,"Lid van het Vlaams parlement",NULL,"/ludo.vancampenhout");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Luk","Van Biesen","Luk Van Biesen",12,"Lid van de Kamer","@LukVanBiesen","/lukvanbiesen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Lydia","Peeters","Lydia Peeters",12,"Lid van het Vlaams parlement","@Lydiapeeters","/lydia.peeters.73");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Lyseline","Louvigny","Lyseline Louvigny",9,"Lid van het parlement Waals gewest","@LyselineL","/lyseline");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Magali","Dock","Magali Dock",9,"Lid van het parlement Waals gewest",NULL,"/magali.dock");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Magali","Plovie","Magali Plovie",5,"Lid van het Brussels parlement","@MagaliPlovie","/dffdfdfdf454");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Maggie","De Block","Maggie De Block",12,"Minister van Sociale Zaken en Volksgezondheid","@Maggie_DeBlock","/FanVanMaggieDeBlock");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Mahinur","Ozdemir","Mahinur Ozdemir",2,"Lid van het Brussels parlement","@Mahinurozdemir","/Mahinur-Özdemir-114717438545962");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Manuela","Van Werde","Manuela Van Werde",10,"Lid van het Vlaams parlement","@manuelavanwerde","/manuela.vanwerde");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marc","Hendrickx","Marc Hendrickx",10,"Lid van het Vlaams parlement","@marc_hendrickx","/marc.hendrickx.7165");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marc","Loewenstein","Marc Loewenstein",7,"Lid van het Brussels parlement","@MarcLoewenstein","/defi.loewenstein");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marc","Tarabella","Marc Tarabella",14,"Lid van het Europees parlement","@marctarabella","/Marc-Tarabella-440244735250");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marc","Van Peel","Marc Van Peel",1,"Antwerps gemeenteraadslid","@MarcVanPeel","/marc.vanpeel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marc-Jean","Ghyssels","Marc-Jean Ghyssels",14,"Lid van het Brussels parlement","@Ghysselsmj","/ghyssels123456789");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marcel","Cheron","Marcel Cheron",6,"Lid van de Kamer",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marco","Van Hees","Marco Van Hees",16,"Lid van de Kamer","@Marco_VanHees","/Marco-Van-Hees-668995839824890");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marianne","Thyssen","Marianne Thyssen",1,"Lid van het Europees parlement","@mariannethyssen","/mariannethyssen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marie","Arena","Marie Arena",14,"Lid van het Europees parlement","@Mariearenaps","/mariearenaPS");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marie Christine","Marghem","Marie Christine Marghem",9,"Minister van Energie, Leefmilieu en Duurzame Ontwikkeling","@MCMarghem","/mc.marghem");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marie-Dominique","Simonet","Marie-Dominique Simonet",2,"Lid van het parlement Waals gewest","@MDSimonet","/Marie-Dominique-Simonet-634255089973446/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marie-Françoise","Nicaise","Marie-Françoise Nicaise",9,"Lid van het parlement Waals gewest",NULL,"/mfnicaise");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marie-Martine","Schyns","Marie-Martine Schyns",2,"lid van de regering Federatie Wallonië-Brussel","@MM_Schyns","/mmschyns");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marino","Keulen","Marino Keulen",12,"Lid van het Vlaams parlement","@KeulenMarino","/marino.Keulen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marion","Lemesre","Marion Lemesre",9,"Lid van het Brussels parlement","@MarionLemesre","/Marion-Lemesre-81267641804");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marius","Meremans","Marius Meremans",10,"Lid van het Vlaams parlement","@MariusMeremans","/marius.meremans");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Mark","Demesmaeker","Mark Demesmaeker",10,"Lid van het Europees parlement","@markdemesmaeker","/demesmaekermark");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Marnic","De Meulemeester","Marnic De Meulemeester",12,"Lid van het Vlaams parlement",NULL,"/marnicdemeulemeester");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Martijn","Van Esbroeck","Martijn Van Esbroeck",10,"Antwerps gemeenteraadslid","@Martijn_Stad_A",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Martine","Fournier","Martine Fournier",1,"Lid van het Vlaams parlement","@martine_menen","/martine.fournier");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Martine","Payfa","Martine Payfa",7,"Lid van het Brussels parlement","@MartinePayfa","/martine.payfa");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Martine","Taelman","Martine Taelman",12,"Lid van het Vlaams parlement","@martinetaelman","/taelman1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Martine","Vrints","Martine Vrints",10,"Antwerps gemeenteraadslid","@VrintsMartine","/martine.vrints");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Mathias","De Clercq","Mathias De Clercq",12,"Lid van het Vlaams parlement","@MathiasDeClercq","/mathias.declercq");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Mathilde","El Bakri","Mathilde El Bakri",17,"Lid van het Brussels parlement","@MathildeElBakri","/mathilde.elbakri");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Mathilde","Vandorpe","Mathilde Vandorpe",2,"Lid van het parlement Waals gewest","@m_vandorpe","/mathildevandorpe1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Matthias","Diependaele","Matthias Diependaele",10,"Lid van het Vlaams parlement","@MDiependaele","/matthias.diependaele");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Matthieu","Daele","Matthieu Daele",5,"Lid van het parlement Waals gewest","@MattDaele","/matthieudaele");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Maurice","Mottard","Maurice Mottard",14,"Lid van het parlement Waals gewest",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Mauro","Lenzini","Mauro Lenzini",14,"Lid van het parlement Waals gewest","@LenziniMauro",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Maxime","Prévot","Maxime Prévot",2,"Lid van het parlement Waals gewest","@prevotmaxime","/maximeprevotbis");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Maya","Detiège","Maya Detiège",19,"Lid van de Kamer",NULL,"/people/Maya-Detiege/100007324998400");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Maya","Detiège","Maya Detiège",19,"Antwerps gemeenteraadslid",NULL,"/profile.php?id=100007324998400");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Mercedes","Van Volcem","Mercedes Van Volcem",12,"Lid van het Vlaams parlement","@MercedesVVolcem","/mercedes.vanvolcem");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Meryame","Kitir","Meryame Kitir",19,"Lid van de Kamer","@MeryameKitir","/meryame.kitir");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Meyrem","Almaci","Meyrem Almaci",6,"Partijvoorzitter Lid van de Kamer","@MeyremAlmaci","/meyremalmaci");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Michaël","Verbauwhede","Michaël Verbauwhede",17,"Lid van het Brussels parlement","@mverbauwhede","/verbauwhedemichael");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Michaël","Vossaert","Michaël Vossaert",7,"Lid van het Brussels parlement","@VossaertMichal","/michael.vossaert");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Michel","Colson","Michel Colson",7,"Lid van het Brussels parlement",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Michel","de Lamotte","Michel de Lamotte",2,"Lid van de Kamer","@MicheldeLamotte","/delamottemichel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Michel","Doomst","Michel Doomst",1,"Lid van het Vlaams parlement","@micheldoomst","/michel.doomst");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Michèle","Carthé","Michèle Carthé",14,"Lid van het Brussels parlement",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Michèle","Hostekint","Michèle Hostekint",19,"Lid van het Vlaams parlement","@mhostekint","/michele.hostekint");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Miranda","Van Eetvelde","Miranda Van Eetvelde",10,"Lid van het Vlaams parlement","@mveetvelde","/miranda.vaneetvelde");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Mohamed","Azzouzi","Mohamed Azzouzi",14,"Lid van het Brussels parlement",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Mohamed","Ouriaghli","Mohamed Ouriaghli",14,"Lid van het Brussels parlement","@Ouri_Mohamed","/Mohamed-Ouriaghli-193547654021516");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Monica","De Coninck","Monica De Coninck",19,"Lid van de Kamer","@MonicaDeConinck","/monica.deconinck.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Monica","De Conninck","Monica De Conninck",19,"Antwerps gemeenteraadslid","@MonicaDeConinck","/monica.deconinck.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Muriel","Gerkens","Muriel Gerkens",6,"Lid van de Kamer",NULL,"/muriel.gerkens.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Nabilla","Ait Daoud","Nabilla Ait Daoud",10,"Antwerpse schepen bevoegd voor cultuur, kinderopvang, personeel, loketten en ontwikkelingssamenwerking","@NabillaAitDaoud","/SchepenNabillaAitDaoud");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Nadia","El Yousfi","Nadia El Yousfi",14,"Lid van het Brussels parlement","@ElYousfiNadia","/elyousfinadia");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Nadia","Sminate","Nadia Sminate",10,"Lid van het Vlaams parlement","@NadiaSminate","/nadia.sminate");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Nahima","Lanjri","Nahima Lanjri",1,"Lid van de Kamer","@NahimaLanjri","/Nahima.lanjri2");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Nathalie","Muylle","Nathalie Muylle",1,"Lid van de Kamer","@nathaliemuylle","/nathalie.muylle.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Nawal","Ben Hamou","Nawal Ben Hamou",14,"Lid van de Kamer","@nawalbenhamou","/nawalbenhamou");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Nele","Lijnen","Nele Lijnen",12,"Lid van de Kamer","@Nelelijnen","/nele.lijnen.771");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Nicolas","Martin","Nicolas Martin",14,"Lid van het parlement Waals gewest","@NMartinPS","/PS.nicolasmartin");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Nicolas","Tzanetatos","Nicolas Tzanetatos",9,"Lid van het parlement Waals gewest","@NTzanetatos","/tzanetatosparlementaire");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Olga","Zrihen","Olga Zrihen",14,"Lid van het parlement Waals gewest","@ozrihen","/olga.zrihen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Olivier","Chastel","Olivier Chastel",9,"Lid van de Kamer","@OChastel","/MR.olivierchastel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Olivier","de Clippele","Olivier de Clippele",9,"Lid van het Brussels parlement",NULL,"/olivier.declippele");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Olivier","Destrebecq","Olivier Destrebecq",9,"Lid van het parlement Waals gewest","@ODestrebecq","/Odestre");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Olivier","Maingain","Olivier Maingain",4,"Lid van de Kamer","@OlivierMaingain","/Olivier-Maingain-477748085719328/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Olivier","Maroy","Olivier Maroy",9,"Lid van het parlement Waals gewest","@oliviermaroy","/Olivier.Maroy.MR");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Orry","Van de Wauwer","Orry Van de Wauwer",1,"Lid van het Vlaams parlement","@orry_vdw","/orry.vdw");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ortwin","Depoortere","Ortwin Depoortere",22,"Lid van het Vlaams parlement","@OrtwinDepo","/Ortwin-Depoortere-1823284994606520");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Özlem","Özen","Özlem Özen",14,"Lid van de Kamer","@OzlemOzen1","/Özlem-Özen-138947689489837/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Pascal","Arimont","Pascal Arimont",3,"Lid van het Europees parlement","@pascal_arimont","/pascalarimont.official");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Pascal","Baurain","Pascal Baurain",2,"Lid van het parlement Waals gewest","@PascalBaurain","/deputebaurain");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Patricia","Ceysens","Patricia Ceysens",12,"Lid van de Kamer","@patriciaceysens","/patricia.ceysens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Patricia","Potigny","Patricia Potigny",9,"Lid van het parlement Waals gewest",NULL,"/patricia.potigny");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Patrick","Dewael","Patrick Dewael",12,"Lid van de Kamer","@PatrickDewael","/dewaelp");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Patrick","Janssen","Patrick Janssen",1,"Antwerps gemeenteraadslid","@patrickjanssen","/JanssenPat");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Patrick","Lecerf","Patrick Lecerf",9,"Lid van het parlement Waals gewest","@patrick_lecerf","/lecerfpatrick");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Patrick","Prévot","Patrick Prévot",14,"Lid van het parlement Waals gewest","@Pprevot","/Patrick-Prévot-445466155584975");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Paul","Cordy","Paul Cordy",10,"Lid van het Vlaams parlement","@PaulCordy","/paul.cordy.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Paul","Delva","Paul Delva",1,"Lid van het Brussels parlement","@Paul_Delva","/paul.delva.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Paul","Furlan","Paul Furlan",14,"Lid van het parlement Waals gewest","@Paul_Furlan","/furlan.p");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Paul","Van Miert","Paul Van Miert",10,"Lid van het Vlaams parlement","@VanMiertPaul","/paul.van.miert");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Paul-Olivier","Delannois","Paul-Olivier Delannois",14,"Lid van de Kamer","@/","/podelannois");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Peter","Buysrogge","Peter Buysrogge",10,"Lid van de Kamer","@PeterBuysrogge","/pbuysrogge");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Peter","De Roover","Peter De Roover",10,"Lid van de Kamer","@PeterDeRoover1","/peter.deroover.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Peter","Dedecker","Peter Dedecker",10,"Lid van de Kamer","@peterdedecker","/peterdedeckernva");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Peter","Luykx","Peter Luykx",10,"Lid van de Kamer","@peerlux","/peter.luykx.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Peter","Persyn","Peter Persyn",10,"Lid van het Vlaams parlement","@peter_persyn","/peter.persyn.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Peter","Van Rompuy","Peter Van Rompuy",1,"Lid van het Vlaams parlement","@Petervanrompuy","/peter.rompuy");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Peter","Vanvelthoven","Peter Vanvelthoven",19,"Lid van de Kamer","@VvelthovenPeter","/pvanvelthoven");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Peter","Wouters","Peter Wouters",10,"Lid van het Vlaams parlement","@wouters_peter","/peter.wouters.39");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philip","Heylen","Philip Heylen",1,"Antwerps gemeenteraadslid","@PhilipHeylen","/philipheylen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philipe","Muyters","Philipe Muyters",10,"Vlaams Minister van Werk, Economie, Innovatie en Sport","@philippemuyters","/muytersphilippe");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","Blanchart","Philippe Blanchart",14,"Lid van de Kamer",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","Bracaval","Philippe Bracaval",9,"Lid van het parlement Waals gewest",NULL,"/philippe.bracaval.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","Courard","Philippe Courard",14,"Lid van het parlement Waals gewest","@CourardPhilippe","/Philippe.Courard.Fan");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","De backer","Philippe De backer",12,"Staatssecretaris van Bestrijding van de sociale fraude, Privacy en Noordzee","@debackerphil","/debackerphil");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","Dodrimont","Philippe Dodrimont",9,"Lid van het parlement Waals gewest","@DODRIMONTPhilip","/dodrimont.philippe");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","Goffin","Philippe Goffin",9,"Lid van de Kamer",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","Henry","Philippe Henry",5,"Lid van het parlement Waals gewest","@phh_Henry","/PhilippeHenryEcolo");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","Knaepen","Philippe Knaepen",9,"Lid van het parlement Waals gewest","@philippeknaepen","/PhilippeKnaepenofficiel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","Lamberts","Philippe Lamberts",5,"Lid van het Europees parlement","@LambrechtP",NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Philippe","Pivin","Philippe Pivin",9,"Lid van de Kamer",NULL,"/pivinph");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Pierre","Kompany","Pierre Kompany",2,"Lid van het Brussels parlement","@PierreKompany","/pierrekompanyganshoren");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Pierre-Yves","Dermagne","Pierre-Yves Dermagne",14,"Lid van het parlement Waals gewest","@PYDermagne","/PYDermagne");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Pierre-Yves","Jeholet","Pierre-Yves Jeholet",9,"lid van de regering Federatie Wallonië-Brussel","@PYJeholet","/Pierre-Yves-Jeholet-22359873725");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Piet","De Bruyn","Piet De Bruyn",10,"Lid van het Vlaams parlement","@PietDeBruyn","/pietdebruyn");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Pieter","De Crem","Pieter De Crem",1,"Staatssecretaris van Buitenlandse handel","@pieterdecrem","/pieterdecrem");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Rachid","Madrana","Rachid Madrana",14,"lid van de regering Federatie Wallonië-Brussel",NULL,"/rachid.madrane");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Raf","Terwingen","Raf Terwingen",1,"Lid van de Kamer","@Rafterwingen","/raf.terwingen");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Raoul","Hedebouw","Raoul Hedebouw",16,"Lid van de Kamer","@RaoulHedebouw","/raoul.hedebouw.pvda");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Renaat","Landuyt","Renaat Landuyt",19,"Lid van het Vlaams parlement","@RLanduyt","/renaat.landuyt");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Renate","Hufkens","Renate Hufkens",10,"Lid van de Kamer","@RenateHufkens","/renate.hufkens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"René","Collin","René Collin",2,"lid van de regering Federatie Wallonië-Brussel","@Rene_Collin","/ReneCollin");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"René","Coppens","René Coppens",12,"Lid van het Brussels parlement",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Richard","Miller","Richard Miller",9,"Lid van de Kamer","@millerrichardmr","/profile.php?id=100004080708483&hc_ref=ARRO0UMlnkGAwNPmr31nPFuwMpuYOrJH9WiNwWRpzRVvfxJbNI-XrJFrWLqRLoIH-T8&fref=nf&pnref=story");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ridouane","Chahid","Ridouane Chahid",14,"Lid van het Brussels parlement","@RidouaneChahid","/ridouane.chahid");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Rik","Daems","Rik Daems",12,"Lid van het Vlaams parlement","@RikDaems","/pages/Rik-Daems/135504466493706");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Rita","Bellens","Rita Bellens",10,"Lid van de Kamer","@BellensRita","/rita.bellens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Rita","Gantois","Rita Gantois",10,"Lid van de Kamer","@ritagantois1","/Rita-Gantois-306815242860827");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Rob","Beenders","Rob Beenders",19,"Lid van het Vlaams parlement","@Robbeenders","/robbeenders");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Rob","Van de Velde","Rob Van de Velde",10,"Ex-politicus","@robvandevelde","/vandevelderob");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Robert","Van de Velde","Robert Van de Velde",10,"Lid van de Kamer","@robvandevelde","/Robert-Van-De-Velde-1504993966434742/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Robert","Voorhamme","Robert Voorhamme",19,"Antwerps gemeenteraadslid",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Robrecht","Bothuyne","Robrecht Bothuyne",1,"Lid van het Vlaams parlement","@RobrechtB","/robrecht.bothuyne");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Roel","Deseyn","Roel Deseyn",1,"Lid van de Kamer","@roeldeseyn","/RoelDeseyn");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ruddy","Warnier","Ruddy Warnier",15,"Lid van het parlement Waals gewest","@RuddyWarnier","/warnier.r");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Rudy","Demotte","Rudy Demotte",14,"minister-president van de Franse Gemeenschapsregering","@demotterudy","/rudy.demotte");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sabien","Lahaye-Battheu","Sabien Lahaye-Battheu",12,"Lid van de Kamer","@SBattheu","/sabienbattheu");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sabine","de Bethune","Sabine de Bethune",1,"Lid van het Vlaams parlement","@SabinedeBethune","/sabinedebethune");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sabine","Vermeulen","Sabine Vermeulen",10,"Lid van het Vlaams parlement","@Sab_Vermeulen","/sabine.vermeulen.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sander","Loones","Sander Loones",10,"Lid van het Europees parlement","@SanderLoones","/SanderLoonesNVA");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sarah","Smeyers","Sarah Smeyers",10,"Lid van de Kamer","@SarahSmeyers","/Sarah-Smeyers-95712061024/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sébastian","Pirlot","Sébastian Pirlot",14,"Lid van de Kamer",NULL,"/sebastian.pirlotter");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Serdar","Kilic","Serdar Kilic",14,"Lid van het parlement Waals gewest",NULL,"/Serdar.KILIC1979");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Serge","de Patoul","Serge de Patoul",7,"Lid van het Brussels parlement",NULL,"/profile.php?id=100008767097420");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Servais","Verherstraeten","Servais Verherstraeten",1,"Lid van de Kamer","@ServaisV","/servais.verherstraeten");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sevket","Temiz","Sevket Temiz",14,"Lid van het Brussels parlement","@sevketemiz","/sevket.temiz");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Siegfried","Bracke","Siegfried Bracke",10,"Lid van de Kamer","@sthbracke","/siegfried.bracke.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Simone","Susskind","Simone Susskind",14,"Lid van het Brussels parlement","@simonesusskind","/susskindsimone");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sofie","Joosen","Sofie Joosen",10,"Lid van het Vlaams parlement","@SofieJoosen","/sofie.joosen.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sonja","Becq","Sonja Becq",1,"Lid van de Kamer","@sonjabecq","/Becqsonja");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sonja","Claes","Sonja Claes",1,"Lid van het Vlaams parlement","@sonjaclaes","/sonja.claes.94");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sophie","De Wit","Sophie De Wit",10,"Lid van de Kamer","@DeWitSophie","/Sophie-De-Wit-165796101293/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sophie","Pécriaux","Sophie Pécriaux",14,"Lid van het parlement Waals gewest","@PecriauxSophie","/sophie.pecriauxbis");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sophie","Wilmès","Sophie Wilmès",9,"Minister van Begroting en van Ambtenaren­zaken","@Sophie_Wilmes","/Sophie-Wilmès-494853240530488");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Stefaan","Sintobin","Stefaan Sintobin",22,"Lid van het Vlaams parlement","@StefaanSintobin","/stefaan.sintobin");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Stefaan","Van Hecke","Stefaan Van Hecke",6,"Lid van de Kamer","@SVHecke","/stefaan.vanhecke.1");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Stefaan","Vercamer","Stefaan Vercamer",1,"Lid van de Kamer","@Stefaanvercamer","/stefaan.vercamer");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Stefan","Cornelis","Stefan Cornelis",12,"Lid van het Brussels parlement","@CornelisStefan","/StefanCornelisBrussel");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Stéphane","Crusnière","Stéphane Crusnière",14,"Lid van de Kamer","@Steph_Crusniere","/Stéphane-Crusnière-1475336276030351");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Stéphane","Hazée","Stéphane Hazée",5,"Lid van het parlement Waals gewest","@Steph_le_vert","/stephane.hazee");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Stéphanie","Thoron","Stéphanie Thoron",9,"Lid van de Kamer",NULL,"/stephanie.thoron");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Steve","Vandenberghe","Steve Vandenberghe",19,"Lid van het Vlaams parlement","@steve_vdb","/steve.vandenberghe.bredene");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Steven","Vandeput","Steven Vandeput",10,"Minister van Defensie","@svandeput","/Steven-Vandeput-983442595060481");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sven","Gatz","Sven Gatz",12,"Vlaams Minister van Cultuur, Media en Brussel","@svengatz","/GatzSven");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Sybille","de Coster-Bauchau","Sybille de Coster-Bauchau",9,"Lid van de Kamer",NULL,"/SybilledeCosterBauchau");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Theo","Francken","Theo Francken",10,"Staatssecretaris van Asiel en migratie","@FranckenTheo","/franckentheo");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Tim","Vandenput","Tim Vandenput",12,"Lid van de Kamer","@TimVandenput","/tim.vandenput");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Tine","Soens","Tine Soens",19,"Lid van het Vlaams parlement","@TineSoens","/tine.soens");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Tine","van der Vloet","Tine van der Vloet",10,"Lid van het Vlaams parlement","@TinevanderVloet","/tine.vandervloet");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Tinne","Rombouts","Tinne Rombouts",1,"Lid van het Vlaams parlement","@TinneRombouts","/RomboutsTinne");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Tom","Van Grieken","Tom Van Grieken",22,"Partijvoorzitter en Lid van het Vlaams parlement","@tomvangrieken","/vangriekentom");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Tom","Vandenkendelaere","Tom Vandenkendelaere",1,"Lid van het Europees parlement","@tomvdkendelaere","/tomvdkendelaere");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Toon","Wassenberg","Toon Wassenberg",19,"Antwerps gemeenteraadslid","@twassenberg","/toon.wassenberg");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Valérie","De Bue","Valérie De Bue",9,"lid van de regering Federatie Wallonië-Brussel","@ValerieDeBue","/Valérie-De-Bue-261617251408");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Valerie","Taeldeman","Valerie Taeldeman",1,"Lid van het Vlaams parlement",NULL,"/valerie.taeldeman");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Valerie","Van Peel","Valerie Van Peel",10,"Lid van de Kamer","@valerievanpeel","/Vanpeelvalerie");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Valérie","Warzée-Caverenne","Valérie Warzée-Caverenne",9,"Lid van het parlement Waals gewest",NULL,"/valerie.warzeecaverenne");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Vanessa","Matz","Vanessa Matz",2,"Lid van de Kamer",NULL,"/Vanessa-Matz-278758345625756/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Veerle","Heeren","Veerle Heeren",1,"Lid van de Kamer","@veerleheeren","/VeerleHeerenPagina");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Veerle","Wouters","Veerle Wouters",23,"Lid van de Kamer","@Veerle_Wouters","/veerle.wouters.735");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Veli","Yüksel","Veli Yüksel",1,"Lid van de Kamer","@veliyuksel","/Veli-Yüksel-749548238558289/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Vera","Celis","Vera Celis",10,"Lid van het Vlaams parlement","@Vera_Celis","/pages/Vera-Celis/162768798385");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Vera","Drozdik","Vera Drozdik",19,"Antwerps gemeenteraadslid",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Vera","Jans","Vera Jans",1,"Lid van het Vlaams parlement","@verajans3620","/vera.jans.39");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Véronique","Bonni","Véronique Bonni",14,"Lid van het parlement Waals gewest","@VeroniqueBonni","/bonni.veronique");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Véronique","Caprasse","Véronique Caprasse",4,"Lid van de Kamer","@VCaprasse","/Véronique-Caprasse-Députée-1ère-échevine-636969813019554/");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Véronique","Durenne","Véronique Durenne",9,"Lid van het parlement Waals gewest","@Vdurenne","/veronique.durenne");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Véronique","Jamoulle","Véronique Jamoulle",14,"Lid van het Brussels parlement","@verojamoulle","/veronique.jamoulle");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Véronique","Salvi","Véronique Salvi",2,"Lid van het parlement Waals gewest","@veroniquesalvi","/salviveronique");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Veronique","Waroux","Veronique Waroux",2,"Lid van het parlement Waals gewest","@VeroniqueWaroux","/veronique.waroux");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Vic","Van Aelstt","Vic Van Aelstt",10,"Antwerps gemeenteraadslid",NULL,NULL);
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Vincent","De Wolf","Vincent De Wolf",9,"Lid van het Brussels parlement","@VincentDeWolf","/vincentdewolf");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Vincent","Scourneau","Vincent Scourneau",9,"Lid van de Kamer","@scourneau","/vincent.scourneau");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Vincent","Van Peteghem","Vincent Van Peteghem",1,"Lid van de Kamer","@vincent_v_p","/vincentvanpeteghem");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Vincent","Van Quickenborne","Vincent Van Quickenborne",12,"Lid van de Kamer","@VincentVQ","/vincentvq");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Virginie","Gonzalez-Moyano","Virginie Gonzalez-Moyano",14,"Lid van het parlement Waals gewest",NULL,"/virginie.gonzalez.12");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Viviane","Teitelbaum","Viviane Teitelbaum",9,"Lid van het Brussels parlement","@VivTeitelbaum","/VIVIANE-TEITELBAUM-71383025758");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Ward","Kennes","Ward Kennes",1,"Lid van het Vlaams parlement","@ward_kennes","/ward.kennes.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Werner","Janssen","Werner Janssen",10,"Lid van de Kamer","@WernerJanssen00","/werner.janssen.54");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Wilfried","Vandaele","Wilfried Vandaele",10,"Lid van het Vlaams parlement","@WilfriedVdaele","/wilfried.vandaele.7");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Willem","Draps","Willem Draps",9,"Lid van het Brussels parlement",NULL,"/willem.draps");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Willem-Frederik","Schiltz","Willem-Frederik Schiltz",12,"Lid van het Vlaams parlement","@wfschiltz","/wfschiltz");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Willy","Borsus","Willy Borsus",9,"lid van de regering Federatie Wallonië-Brussel","@wborsus","/wborsus");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Willy","Demeyer","Willy Demeyer",14,"Lid van de Kamer","@Willy_Demeyer","/willy.demeyer");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Willy","Segers","Willy Segers",10,"Lid van het Vlaams parlement","@Willy_Segers","/pages/Willy-Segers/172565137927");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Wim","Van der Donckt","Wim Van der Donckt",10,"Lid van de Kamer","@wimvanderdonckt","/wim.vanderdonckt");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Wim","Van Ossellaer","Wim Van Ossellaer",22,"Antwerps gemeenteraadslid","@WimVanOsselaer1","/wim.vanosselaer.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Wouter","Beke","Wouter Beke",1,"Partijvoorzitter en Lid van de Kamer","@wbeke","/wouter.beke");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Wouter","De Vriendt","Wouter De Vriendt",6,"Lid van de Kamer","@WouterDeVriendt","/wouter.devriendt.3");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Wouter","Raskin","Wouter Raskin",10,"Lid van de Kamer","@RaskinWouter","/Wouter-Raskin-1772158556137518");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Wouter","Vanbesien","Wouter Vanbesien",8,"Lid van het Vlaams parlement","@WouterVanBesien","/wouter.vanbesien");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Yamila","Idrissi","Yamila Idrissi",19,"Lid van het Vlaams parlement","@Yamila_Idrissi","/yamila.idrissi");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Yasmine","Kherbache","Yasmine Kherbache",19,"Lid van het Vlaams parlement","@Kherbache","/yasmine.kherbache");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Yoleen","Van Camp","Yoleen Van Camp",10,"Lid van de Kamer","@YoleenVanCamp","/yoleen.vancamp");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Youssef","Handichi","Youssef Handichi",17,"Lid van het Brussels parlement","@HandichiY","/youssef.handichi.5");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Yves","Evrard","Yves Evrard",9,"Lid van het parlement Waals gewest",NULL,"/yves.evrard.9");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Zahoor","Manzoor","Zahoor Manzoor",14,"Lid van het Brussels parlement","@ZahoorEManzoor","/manzoor.z.ellahi");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Zoé","Genot","Zoé Genot",5,"Lid van het Brussels parlement","@ZoeGenot","/zoe.genotsaintjosse");
INSERT INTO pol_all VALUES (NULL);
INSERT INTO pol_persons(id,pol_id,first_name,last_name,full_name,party_id,info,twitter,facebook) VALUES (NULL,LAST_INSERT_ID(),"Zuhal","Demir","Zuhal Demir",10,"Staatssecretaris van Armoedebestrijding, Gelijke Kansen, Personen met beperking en Wetenschapsbeleid","@Zu_Demir","/Zuhal-Demir-453932394796444");