--количество исполнителей в каждом жанре

select count(performers_id), g.genre_name from performersgenres pg 
join genres g on pg.genres_id = g.id
join performers p on pg.performers_id = p.id 
group by genre_name; 

--количество треков, вошедших в альбомы 2019-2020 годов

select count(track_name) from tracks t 
join albums a on t.album_id = a.id 
where a.release_year BETWEEN 2019 AND 2020;

--средняя продолжительность треков по каждому альбому

select a.album_name, avg(track_duration) from tracks t 
join albums a on t.album_id = a.id 
group by album_name;

--все исполнители, которые не выпустили альбомы в 2020 году

select performer_name from performers p 
join albumsperformers ap on p.id = ap.performers_id 
join albums a on ap.albums_id = a.id 
where a.release_year <> 2020;

--названия сборников, в которых присутствует конкретный исполнитель

select collection_name from collections c 
join collectionstracks ct on c.id = ct.collection_id 
join tracks t on ct.tracks_id = t.id 
join albums a on t.album_id = a.id 
join albumsperformers ap on a.id = ap.albums_id 
join performers p on ap.performers_id = p.id 
where p.performer_name = 'Queen';

--название альбомов, в которых присутствуют исполнители более 1 жанра

select album_name from albums a 
join albumsperformers ap on a.id = ap.albums_id 
join performers p on ap.performers_id = p.id 
join performersgenres pg on p.id = pg.performers_id 
join genres g on pg.genres_id = g.id 
group by a.album_name 
having count(g.genre_name) > 1;

--наименование треков, которые не входят в сборники

select track_name from tracks t 
left join collectionstracks ct on t.id = ct.tracks_id 
left join collections c on ct.collection_id = c.id 
where ct.collection_id is null; 

--исполнителя(-ей), написавшего самый короткий по продолжительности трек

select performer_name from performers p 
join albumsperformers ap on p.id = ap.performers_id 
join tracks t on ap.albums_id = t.album_id 
where t.track_duration = (select min(track_duration) from tracks);

--название альбомов, содержащих наименьшее количество треков

select album_name, count(track_name) from albums a 
join tracks t on a.id = t.album_id 
group by album_name 
having count(track_name) = (
	select count(track_name) from tracks t2 
	join albums a2 on t2.album_id = a2.id  
	group by album_name 
	order by count(track_name) limit 1);
