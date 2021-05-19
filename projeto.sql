CREATE DATABASE twitter DEFAULT CHARSET = utf8mb4 DEFAULT COLLATE = utf8mb4_unicode_ci;
USE twitter;

CREATE TABLE IF NOT EXISTS tweet (
  idTweet INT NOT NULL AUTO_INCREMENT,
  idTweetApi BIGINT(20) NOT NULL,
  textTweet MEDIUMTEXT NOT NULL,
  dataTweet DATETIME NOT NULL,
  retweetTweet INT NOT NULL,
  favoriteTweet INT NOT NULL,
  keyword VARCHAR(20) NOT NULL,
  PRIMARY KEY (idTweet));

CREATE TABLE IF NOT EXISTS user (
  idUser INT NOT NULL AUTO_INCREMENT,
  idUserTwitter BIGINT(20),
  nameUser VARCHAR(50) NOT NULL,
  locationUser VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (idUser));

CREATE TABLE IF NOT EXISTS TweetUser (
  idTweetUser INT auto_increment,
  tweet_idTweet INT NOT NULL,
  user_idUser INT NOT NULL,
  PRIMARY KEY (idTweetUser,tweet_idTweet, user_idUser),
  INDEX fk_tweet_has_user_user1_idx (user_idUser ASC) VISIBLE,
  INDEX fk_tweet_has_user_tweet1_idx (tweet_idTweet ASC) VISIBLE,
  CONSTRAINT fk_tweet_has_user_tweet1
    FOREIGN KEY (tweet_idTweet)
    REFERENCES tweet (idTweet)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_tweet_has_user_user1
    FOREIGN KEY (user_idUser)
    REFERENCES user (idUser)
    ON DELETE CASCADE
    ON UPDATE CASCADE);