DELETE FROM mentions;
ALTER TABLE mentions AUTO_INCREMENT = 1;
DELETE FROM fragments;
ALTER TABLE fragments AUTO_INCREMENT = 1;
DELETE FROM doc_tweets;
DELETE FROM doc_news;
DELETE FROM doc_all;
ALTER TABLE doc_all AUTO_INCREMENT = 1;