create schema justwatch;
use justwatch;
create table user (
	id int not null, primary key(id), 
    email varchar(50), fname varchar(50), lname varchar(50),
    unique(email));
create table streamingServices (
	id varchar(50) not null, primary key(id),
    name varchar(50), url varchar(100));
create table media (
	id varchar(50) not null, primary key(id), type enum('TV', 'Movie'),
    title varchar(100), rating varchar(50), runtime varchar(50), ageRating varchar(50), releaseYear char(4),
    country varchar(50), imageURL text, synopsis text);
create table audioSubs (
	media_id varchar(50) not null, lang varchar(50), 
    primary key(media_id, lang), 
    foreign key (media_id) references media(id));
create table genres (
	media_id varchar(50) not null, genre varchar(50),
    primary key(media_id, genre), 
    foreign key (media_id) references media(id));
create table movieQualityPrice (
	media_id varchar(50) not null,service_id varchar(50) not null,quality enum('SD', 'HD', '4K'), price varchar(50),
    status enum('rent', 'buy', 'subscription'),
    primary key (media_id, service_id, quality, price, status), 
    foreign key (media_id) references media(id),
    foreign key (service_id) references streamingServices(id));
create table showQuality (
	media_id varchar(50) not null,service_id varchar(50) not null,quality enum('SD', 'HD', '4K'),status enum ('stream', 'rent', 'buy'),
    primary key (media_id, service_id, quality, status), 
    foreign key (media_id) references media(id),
    foreign key (service_id) references streamingServices(id));
create table numSeasons (
	tv_id varchar(50)not null, num int not null,
    primary key (tv_id, num),
    foreign key (tv_id) references media(id));
create table season (
	tv_id varchar(50) not null, seasonNum varchar(10), synopsis text, releaseYear char(4), numEpisodes int,
    primary key (tv_id, seasonNum), 
    foreign key(tv_id) references media(id));
create table episode (
	tv_id varchar(50) not null, seasonNum varchar(10) not null, episodeNum varchar(50) not null,
    title varchar(30), synopsis text, 
    primary key (tv_id, seasonNum, episodeNum), 
    foreign key(tv_id, seasonNum) references season(tv_id, seasonNum));
create table sports (
	id varchar(50) not null, primary key(id),
    sport varchar(50), league varchar(50), competition varchar(100), start_datetime datetime, end_datetime datetime,
    title varchar(70));
create table competitors (
	sport_id varchar(50) not null, competitor varchar(70) not null, 
    primary key (sport_id, competitor), 
    foreign key (sport_id) references sports(id));
create table castMember (
	member_id varchar(50) not null, primary key(member_id),
    fname varchar(50), lname varchar(50));
create table access (
	user_id int not null, media_id varchar(50), dateAndTime datetime, serviceID varchar(50), 
    primary key(user_id, media_id, dateAndTime),
    foreign key (user_id) references user(id),
    foreign key (media_id) references media(id),
    foreign key (serviceID) references streamingServices (id));
create table liked (
	user_id int not null, media_id varchar(50) not null, list_id varchar(50),
    primary key (user_id, media_id, list_id),
    foreign key (user_id) references user(id),
    foreign key (media_id) references media(id));
create table watch (
	user_id int not null, media_id varchar(50) not null, list_id varchar(50),
    primary key (user_id, media_id, list_id),
    foreign key (user_id) references user(id),
    foreign key (media_id) references media(id));
create table hasCastMember (
	media_id varchar(50) not null, member_id varchar(50), role varchar(50),
    primary key (media_id, member_id),
    foreign key (media_id) references media(id), 
    foreign key (member_id) references castMember(member_id));
create table hostsMedia (
	streaming_id varchar(50), media_id varchar(50),
    primary key (streaming_id, media_id),
    foreign key (streaming_id) references streamingServices(id),
    foreign key (media_id) references media(id));
create table hostsSports (
	streaming_id varchar(50), sports_id varchar(50),
    primary key (streaming_id, sports_id),
    foreign key (streaming_id) references streamingServices(id),
    foreign key (sports_id) references sports(id));
