-- Query 1:
select media.title as 'Media', 
	   streamingServices.name as 'Streaming Service', 
       movieQualityPrice.quality as 'Quality',
	   movieQualityPrice.price as 'Price', 
       media.imageURL as 'URL' 
from media 
join movieQualityPrice on media.id = movieQualityPrice.media_id 
join streamingServices on movieQualityPrice.service_id = streamingServices.id 
where media.title = 'Dune';
    
-- Query 2:
select media.id as 'Show ID',
	   media.title as 'Title', 
       media.rating as 'Rating', 
       media.runtime as 'Runtime', 
       media.ageRating as 'Age Rating',
       media.releaseYear as 'Release Year',
       media.country as 'Country', 
       media.imageURL as 'URL', 
       media.synopsis as 'Synopsis'
from media
join numSeasons on media.id = numSeasons.tv_id where num > 2;

-- Query 3:
select castMember.fname as 'First Name', 
	   castMember.lname as 'Last Name', 
       media.title as 'Media', 
       media.type as 'Type',
       hasCastMember.role as 'Role',
       media.releaseYear as 'Year', 
       media.runtime as 'Runtime',
       media.rating as 'Rating'
from castMember 
join hasCastMember on hasCastMember.member_id = castMember.member_id 
join media on media.id = hasCastMember.media_id
where castMember.fname = 'Ryan' and castMember.lname = 'Gosling';

-- Query 4:
select media.title as 'Movie',
	   genres.genre as 'Genre'
from media 
join genres on media.id = genres.media_id
where genres.genre = 'Drama' or (genres.genre = 'Romance' and media.id in (select genres.media_id from genres where genres.genre = 'Comedy'));

-- Query 5:
select episode.episodeNum as 'Episode Number', 
	   episode.title as 'Episode Title', 
       media.title as 'Show',
       episode.seasonNum as 'Season Number', 
       season.releaseYear as 'Date', 
       episode.synopsis as 'Episode Synopsis'
from media
join season on media.id = season.tv_id
join episode on season.tv_id = episode.tv_id and season.seasonNum = episode.seasonNum
where media.title = 'Greys Anatomy';
       
-- Query 6:
select sports.id as 'Event ID',
	   sports.sport as 'Sport', 
	   sports.league as 'League', 
       sports.competition as 'Competition', 
       streamingServices.name as 'Streaming Service',
       sports.start_datetime as 'Start', 
       sports.end_datetime as 'End',
       sports.title as 'Game Title'
from sports 
join hostsSports on sports.id = hostsSports.sports_id
join streamingServices on hostsSports.streaming_id = streamingServices.id
where sports.start_datetime > '2023-11-25 18:30:00' and sports.end_datetime < '2023-11-28 23:00:00';

-- Query 7:
select competitors.competitor as 'Participants'
from competitors
join sports on sports.id = competitors.sport_id
where sports.title = 'Nets vs. Bucks';

-- Query 8:
select media.title as 'Show',
	   max(season.seasonNum) AS 'Season',
       max(episode.episodeNum) AS 'Episode',
       episode.title as 'Title',
       max(season.releaseYear) AS 'Recent Year'
from media
join season on media.id = season.tv_id
join episode on season.tv_id = episode.tv_id and season.seasonNum = episode.seasonNum
where (season.releaseYear, episode.episodeNum) = 
		(select
            max(season.releaseYear),
            max(episode.episodeNum)
         from season
         join episode on season.tv_id = episode.tv_id and season.seasonNum = episode.seasonNum
         where season.releaseYear = (select MAX(releaseYear) from season))
group by media.title, episode.title;

-- Query 9:
select watch.list_id as 'Watchlist',
	   user.email as 'Email', 
	   genres.genre as 'Genre', 
       count(watch.media_id) as 'Count'
from watch 
join user on user.id = watch.user_id
join media on watch.media_id = media.id
join genres on media.id = genres.media_id
where user.email = 'salma.omran21@stjohns.edu'
group by watch.list_id, user.email, genres.genre
order by count(watch.media_id) desc
limit 3;

-- Query 10:
select streamingServices.name as 'Streaming Service', 
	   avg(movieQualityPrice.price) as 'Average Buy Price'
from streamingServices
join movieQualityPrice on streamingServices.id = movieQualityPrice.service_id
where movieQualityPrice.status = 'buy'
group by streamingServices.name;

