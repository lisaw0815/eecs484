INSERT INTO USERS SELECT DISTINCT USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER FROM project1.PUBLIC_USER_INFORMATION;
INSERT INTO FRIENDS SELECT DISTINCT USER1_ID, USER2_ID FROM project1.PUBLIC_ARE_FRIENDS;
INSERT INTO CITIES(CITY_NAME, STATE_NAME, COUNTRY_NAME) SELECT DISTINCT ATC.CITY, ATC.STATE, ATC.COUNTRY FROM (SELECT DISTINCT CURRENT_CITY AS CITY, CURRENT_STATE AS STATE, CURRENT_COUNTRY AS COUNTRY FROM project1.PUBLIC_USER_INFORMATION
UNION
SELECT DISTINCT HOMETOWN_CITY AS CITY, HOMETOWN_STATE AS STATE, HOMETOWN_COUNTRY AS COUNTRY FROM project1.PUBLIC_USER_INFORMATION
UNION
SELECT DISTINCT EVENT_CITY AS CITY, EVENT_STATE AS STATE, EVENT_COUNTRY AS COUNTRY FROM project1.PUBLIC_EVENT_INFORMATION
) ATC;
INSERT INTO USER_CURRENT_CITIES(USER_ID, CURRENT_CITY_ID) SELECT DISTINCT P.USER_ID, C.CITY_ID FROM project1.PUBLIC_USER_INFORMATION P, CITIES C WHERE (C.CITY_NAME = P.CURRENT_CITY AND C.STATE_NAME = P.CURRENT_STATE AND C.COUNTRY_NAME = P.CURRENT_COUNTRY);
INSERT INTO USER_HOMETOWN_CITIES(USER_ID, HOMETOWN_CITY_ID) SELECT DISTINCT P.USER_ID, C.CITY_ID FROM project1.PUBLIC_USER_INFORMATION P, CITIES C WHERE (C.CITY_NAME = P.HOMETOWN_CITY AND C.STATE_NAME = P.HOMETOWN_STATE AND C.COUNTRY_NAME = P.HOMETOWN_COUNTRY);
INSERT INTO PROGRAMS(INSTITUTION, CONCENTRATION, DEGREE) SELECT DISTINCT INSTITUTION_NAME, PROGRAM_CONCENTRATION, PROGRAM_DEGREE FROM project1.PUBLIC_USER_INFORMATION P WHERE P.INSTITUTION_NAME IS NOT NULL;
INSERT INTO EDUCATION SELECT DISTINCT P.USER_ID, PR.PROGRAM_ID, P.PROGRAM_YEAR FROM project1.PUBLIC_USER_INFORMATION P, PROGRAMS PR WHERE (P.INSTITUTION_NAME = PR.INSTITUTION AND P.PROGRAM_CONCENTRATION = PR.CONCENTRATION AND P.PROGRAM_DEGREE = PR.DEGREE);
INSERT INTO USER_EVENTS SELECT DISTINCT P.EVENT_ID, P.EVENT_CREATOR_ID, P.EVENT_NAME, P.EVENT_TAGLINE, P.EVENT_DESCRIPTION, P.EVENT_HOST, P.EVENT_TYPE, P.EVENT_SUBTYPE, P.EVENT_ADDRESS, C.CITY_ID, P.EVENT_START_TIME, P.EVENT_END_TIME FROM project1.PUBLIC_EVENT_INFORMATION P
, CITIES C WHERE (C.CITY_NAME = P.EVENT_CITY AND C.STATE_NAME = P.EVENT_STATE AND C.COUNTRY_NAME = P.EVENT_COUNTRY);
SET AUTOCOMMIT OFF;
INSERT INTO ALBUMS SELECT DISTINCT ALBUM_ID, OWNER_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, COVER_PHOTO_ID FROM project1.PUBLIC_PHOTO_INFORMATION;
INSERT INTO PHOTOS SELECT DISTINCT PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK FROM project1.PUBLIC_PHOTO_INFORMATION;
COMMIT;
SET AUTOCOMMIT ON;
INSERT INTO TAGS SELECT DISTINCT PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE FROM project1.PUBLIC_TAG_INFORMATION;

