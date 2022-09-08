CREATE TABLE IF NOT EXISTS Performers(
	id SERIAL PRIMARY KEY,
	performer_name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Genres (
	id SERIAL PRIMARY KEY,
	genre_name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Albums (
	id SERIAL PRIMARY KEY,
	album_name VARCHAR(80) UNIQUE NOT NULL,
	release_year INTEGER NOT NULL,
	CHECK (release_year > 1900)
);

CREATE TABLE IF NOT EXISTS PerformersGenres (
	genres_id INTEGER REFERENCES Genres(id),
	performers_id INTEGER REFERENCES Performers(id),
	CONSTRAINT pk PRIMARY KEY (genres_id, performers_id)
);

CREATE TABLE IF NOT EXISTS AlbumsPerformers (
	albums_id INTEGER REFERENCES Albums(id),
	performers_id INTEGER REFERENCES Performers(id),
	CONSTRAINT pk_1 PRIMARY KEY (albums_id, performers_id)
);

CREATE TABLE IF NOT EXISTS Tracks (
	id SERIAL PRIMARY KEY,
	track_name TEXT UNIQUE NOT NULL,
	track_duration INTEGER NOT NULL,
	album_id INTEGER NOT NULL REFERENCES Albums(id)
);

CREATE TABLE IF NOT EXISTS Collections (
	id SERIAL PRIMARY KEY,
	collection_name VARCHAR(40) UNIQUE NOT NULL,
	release_year INTEGER NOT NULL,
	CHECK (release_year > 1900)
);

CREATE TABLE IF NOT EXISTS CollectionsTracks (
	collection_id INTEGER REFERENCES Collections(id),
	tracks_id INTEGER REFERENCES Tracks(id),
	CONSTRAINT pk_2 PRIMARY KEY (collection_id, tracks_id)
);
