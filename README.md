RESTful — case study
====================

Challenge
---------

Delelop a RESTful webservice build on [Jersey](http://jersey.java.net) and a client therefor working on iOS with [RestKit](http://www.restkit.org/).

Subject
-------

This is a simple card index for users. All users are store in MySQL database. A client can view, edit, delete and add users though a RESTful webservice.

Get all users information from the card index:

```
	GET: http://localhost:9988/user
```

Get a particular users information from the card index:

```
	GET: http://localhost:9988/user/{id}
```

Edit users information:

```
	PUT: http://localhost:9988/user/{id} with users new data in application/json
```

Add new user to the card index:

```
	POST: http://localhost:9988/user with new users data in application/json
```

Remove existing user from the card index:

```
	DELETE: http://locahost:9988/user/{id}
```

Setup
-----

Setup MySQL database:

```sql
	CREATE DATABASE IF NOT EXISTS `usr_index` CHARACTER SET utf8 COLLATE utf8_general_ci;

	CREATE USER `usr_index`@`localhost` IDENTIFIED BY '123qweASD!8';

	USE `usr_index`;

	CREATE TABLE IF NOT EXISTS `users` (
		`id` int(11) NOT NULL AUTO_INCREMENT,
		`name` varchar(45) DEFAULT NULL,
		`about` varchar(45) DEFAULT NULL,
		`photo` varchar(256) DEFAULT NULL,
		PRIMARY KEY (`id`),
		INDEX (`name`)
	) ENGINE=InnoDB CHARSET=utf8;

	GRANT ALL ON `usr_index`.`users` TO `usr_index`@`localhost` IDENTIFIED BY '123qweASD!8';

	INSERT INTO `users` (`id`, `name`, `about`, `photo`)
	VALUES
		(1, 'Donald Ervin Knuth', 'He is the author of the seminal multi-volume work The Art of Computer Programming.', 'http://upload.wikimedia.org/wikipedia/commons/4/4f/KnuthAtOpenContentAlliance.jpg'),
		(2, 'Alan Turing', 'He was highly influential in the development of computer science, providing a formalisation of the concepts of "algorithm" and "computation" with the Turing machine.', 'http://upload.wikimedia.org/wikipedia/en/c/c8/Alan_Turing_photo.jpg'),
		(3, 'Dennis MacAlistair Ritchie', 'He created the C programming language and, with long-time colleague Ken Thompson, the Unix operating system.', 'http://upload.wikimedia.org/wikipedia/commons/0/01/Dennis_MacAlistair_Ritchie_.jpg'),
		(4, 'Kenneth Lane Thompson', 'http://en.wikipedia.org/wiki/File:Ken_n_dennis.jpg.', 'http://amturing.acm.org/images/lg_aw/4588371.jpg'),
		(5, 'Alan Curtis Kay', ' known for his early pioneering work on object-oriented programming and windowing graphical user interface design, and for coining the phrase, "The best way to predict the future is to invent it."', 'http://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Alan_Kay2.jpg/220px-Alan_Kay2.jpg'),
		(6, 'Dr. James A. Gosling', 'known as the father of the Java programming language.', 'http://upload.wikimedia.org/wikipedia/commons/1/14/James_Gosling_2008.jpg'),
		(7, 'John Doe', 'Im very cool developer!', 'http://allenbukoff.com/newwavepsychology/JohnDoeMasthead.jpg'),
		(8, 'Artem Grebenkin', 'Id like to be here too!', 'http://qph.cf.quoracdn.net/main-thumb-3693412-200-JKfkixwJ5VdmP3FDYZQDbTxdnO1uqP66.jpeg');

```

Start REST server
---------------

Import existing project into Eclipse from RESTServer folder and run it.

Start REST client
------------------

Just open RESTClient.xcodeproj in your XCode and run it in Simulator. There are 2 versions of iOS client. First and default with ARC off and the second on the ARC branch, with ARC on. If you want to use ARC version just checkout the [ARC branch](http://github.com/speechkey/RESTful-Service-Jersey--and-Client-RestKit-/tree/ARC).

Cleanup MySQL after testing
--------------------------

```sql
	DROP DATABASE IF EXISTS `usr_index`;
	DROP USER `usr_index`@`localhost`;
```
