
/* Drop Triggers */

DROP TRIGGER TRI_boards_board_id;
DROP TRIGGER TRI_cans_cancel_id;
DROP TRIGGER TRI_coms_comment_id;
DROP TRIGGER TRI_evals_ev_id;
DROP TRIGGER TRI_nmovies_nmovie_id;
DROP TRIGGER TRI_res_reservation_id;
DROP TRIGGER TRI_rinfo_rinfo_id;
DROP TRIGGER TRI_seatinfo_seat_id;
DROP TRIGGER TRI_theaters_theater_id;
DROP TRIGGER TRI_wishlists_wish_id;



/* Drop Tables */

DROP TABLE cancellations CASCADE CONSTRAINTS;
DROP TABLE comments CASCADE CONSTRAINTS;
DROP TABLE customerboards CASCADE CONSTRAINTS;
DROP TABLE evaluations CASCADE CONSTRAINTS;
DROP TABLE wishlists CASCADE CONSTRAINTS;
DROP TABLE reservationinfo CASCADE CONSTRAINTS;
DROP TABLE seatinfo CASCADE CONSTRAINTS;
DROP TABLE nowmovies CASCADE CONSTRAINTS;
DROP TABLE movies CASCADE CONSTRAINTS;
DROP TABLE reservations CASCADE CONSTRAINTS;
DROP TABLE theaters CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_boards_board_id;
DROP SEQUENCE SEQ_cans_cancel_id;
DROP SEQUENCE SEQ_coms_comment_id;
DROP SEQUENCE SEQ_evals_ev_id;
DROP SEQUENCE SEQ_nmovies_nmovie_id;
DROP SEQUENCE SEQ_res_reservation_id;
DROP SEQUENCE SEQ_rinfo_rinfo_id;
DROP SEQUENCE SEQ_seatinfo_seat_id;
DROP SEQUENCE SEQ_theaters_theater_id;
DROP SEQUENCE SEQ_wishlists_wish_id;




/* Create Sequences */

CREATE SEQUENCE SEQ_boards_board_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_cans_cancel_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_coms_comment_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_evals_ev_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_nmovies_nmovie_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_res_reservation_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_rinfo_rinfo_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_seatinfo_seat_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_theaters_theater_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_wishlists_wish_id INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE cancellations
(
	cancel_id number NOT NULL,
	user_id varchar2(10) NOT NULL,
	seat_id number NOT NULL,
	cancel_date date DEFAULT sysdate NOT NULL,
	PRIMARY KEY (cancel_id)
);


CREATE TABLE comments
(
	comment_id number NOT NULL,
	board_id number NOT NULL,
	user_id varchar2(10) NOT NULL,
	comment_content varchar2(500) NOT NULL,
	comment_date date DEFAULT sysdate NOT NULL,
	PRIMARY KEY (comment_id)
);


CREATE TABLE customerboards
(
	board_id number NOT NULL,
	user_id varchar2(10) NOT NULL,
	board_title varchar2(100) NOT NULL,
	board_content varchar2(500) NOT NULL,
	board_date date DEFAULT sysdate NOT NULL,
	PRIMARY KEY (board_id)
);


CREATE TABLE evaluations
(
	ev_id number NOT NULL,
	user_id varchar2(10) NOT NULL,
	movie_code varchar2(8) NOT NULL,
	ev_rating number NOT NULL,
	ev_comment varchar2(200),
	PRIMARY KEY (ev_id)
);


CREATE TABLE movies
(
	movie_code varchar2(8) NOT NULL,
	movie_title_kr varchar2(4000) NOT NULL,
	movie_title_eng varchar2(4000) NOT NULL,
	movie_genre varchar2(4000) NOT NULL,
	movie_nation varchar2(4000) NOT NULL,
	movie_open_date varchar2(4000),
	movie_director varchar2(4000) NOT NULL,
	movie_img_url varchar2(4000),
	movie_grade varchar2(4000),
	movie_story varchar2(4000),
	movie_actor1 varchar2(4000),
	movie_actor2 varchar2(4000),
	movie_actor3 varchar2(4000),
	movie_actor4 varchar2(4000),
	PRIMARY KEY (movie_code)
);


CREATE TABLE nowmovies
(
	nowmovie_id number NOT NULL,
	movie_code varchar2(8) NOT NULL,
	theater_id number NOT NULL,
	movie_time date NOT NULL,
	PRIMARY KEY (nowmovie_id)
);


CREATE TABLE reservationinfo
(
	reservationinfo_id number NOT NULL,
	seat_id number NOT NULL UNIQUE,
	reservation_id number NOT NULL,
	PRIMARY KEY (reservationinfo_id)
);


CREATE TABLE reservations
(
	reservation_id number NOT NULL,
	user_id varchar2(10) NOT NULL,
	reservation_num number NOT NULL,
	reservation_price number NOT NULL,
	reservation_date date DEFAULT sysdate NOT NULL,
	PRIMARY KEY (reservation_id)
);


CREATE TABLE seatinfo
(
	seat_id number NOT NULL,
	nowmovie_id number NOT NULL,
	seat_no number NOT NULL,
	PRIMARY KEY (seat_id)
);


CREATE TABLE theaters
(
	theater_id number NOT NULL,
	theater_name varchar2(200) NOT NULL,
	PRIMARY KEY (theater_id)
);


CREATE TABLE users
(
	user_id varchar2(10) NOT NULL,
	user_pwd varchar2(10) NOT NULL,
	user_email varchar2(30) NOT NULL UNIQUE,
	user_birthday date NOT NULL,
	user_coupon char DEFAULT 'n' NOT NULL,
	user_point number DEFAULT 0 NOT NULL,
	PRIMARY KEY (user_id)
);


CREATE TABLE wishlists
(
	wish_id number NOT NULL,
	movie_code varchar2(8) NOT NULL,
	user_id varchar2(10) NOT NULL,
	PRIMARY KEY (wish_id)
);



/* Create Foreign Keys */

ALTER TABLE comments
	ADD FOREIGN KEY (board_id)
	REFERENCES customerboards (board_id)
;


ALTER TABLE wishlists
	ADD FOREIGN KEY (movie_code)
	REFERENCES movies (movie_code)
;


ALTER TABLE evaluations
	ADD FOREIGN KEY (movie_code)
	REFERENCES movies (movie_code)
;


ALTER TABLE nowmovies
	ADD FOREIGN KEY (movie_code)
	REFERENCES movies (movie_code)
;


ALTER TABLE seatinfo
	ADD FOREIGN KEY (nowmovie_id)
	REFERENCES nowmovies (nowmovie_id)
;


ALTER TABLE reservationinfo
	ADD FOREIGN KEY (reservation_id)
	REFERENCES reservations (reservation_id)
;


ALTER TABLE cancellations
	ADD FOREIGN KEY (seat_id)
	REFERENCES seatinfo (seat_id)
;


ALTER TABLE reservationinfo
	ADD FOREIGN KEY (seat_id)
	REFERENCES seatinfo (seat_id)
;


ALTER TABLE nowmovies
	ADD FOREIGN KEY (theater_id)
	REFERENCES theaters (theater_id)
;


ALTER TABLE wishlists
	ADD FOREIGN KEY (user_id)
	REFERENCES users (user_id)
;


ALTER TABLE customerboards
	ADD FOREIGN KEY (user_id)
	REFERENCES users (user_id)
;


ALTER TABLE evaluations
	ADD FOREIGN KEY (user_id)
	REFERENCES users (user_id)
;


ALTER TABLE comments
	ADD FOREIGN KEY (user_id)
	REFERENCES users (user_id)
;


ALTER TABLE cancellations
	ADD FOREIGN KEY (user_id)
	REFERENCES users (user_id)
;


ALTER TABLE reservations
	ADD FOREIGN KEY (user_id)
	REFERENCES users (user_id)
;


/* Create Unique Constraints */
ALTER TABLE nowmovies
ADD CONSTRAINT uniq_movie UNIQUE (theater_id, movie_code, movie_time)
;


ALTER TABLE seatinfo
ADD CONSTRAINT uniq_nm UNIQUE (nowmovie_id, seat_no)
;


/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_boards_board_id BEFORE INSERT ON customerboards
FOR EACH ROW
BEGIN
	SELECT SEQ_boards_board_id.nextval
	INTO :new.board_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_cans_cancel_id BEFORE INSERT ON cancellations
FOR EACH ROW
BEGIN
	SELECT SEQ_cans_cancel_id.nextval
	INTO :new.cancel_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_coms_comment_id BEFORE INSERT ON comments
FOR EACH ROW
BEGIN
	SELECT SEQ_coms_comment_id.nextval
	INTO :new.comment_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_evals_ev_id BEFORE INSERT ON evaluations
FOR EACH ROW
BEGIN
	SELECT SEQ_evals_ev_id.nextval
	INTO :new.ev_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_nmovies_nmovie_id BEFORE INSERT ON nowmovies
FOR EACH ROW
BEGIN
	SELECT SEQ_nmovies_nmovie_id.nextval
	INTO :new.nowmovie_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_res_reservation_id BEFORE INSERT ON reservations
FOR EACH ROW
BEGIN
	SELECT SEQ_res_reservation_id.nextval
	INTO :new.reservation_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_rinfo_rinfo_id BEFORE INSERT ON reservationinfo
FOR EACH ROW
BEGIN
	SELECT SEQ_rinfo_rinfo_id.nextval
	INTO :new.reservationinfo_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_seatinfo_seat_id BEFORE INSERT ON seatinfo
FOR EACH ROW
BEGIN
	SELECT SEQ_seatinfo_seat_id.nextval
	INTO :new.seat_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_theaters_theater_id BEFORE INSERT ON theaters
FOR EACH ROW
BEGIN
	SELECT SEQ_theaters_theater_id.nextval
	INTO :new.theater_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_wishlists_wish_id BEFORE INSERT ON wishlists
FOR EACH ROW
BEGIN
	SELECT SEQ_wishlists_wish_id.nextval
	INTO :new.wish_id
	FROM dual;
END;

/




