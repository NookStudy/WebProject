
/* Drop Triggers */

DROP TRIGGER TRI_Gallery_GalleryPostNo;
DROP TRIGGER TRI_Members_memberNo;
DROP TRIGGER TRI_Members_UserNo;



/* Drop Tables */

DROP TABLE Gallery CASCADE CONSTRAINTS;
DROP TABLE Members CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_Gallery_GalleryPostNo;
DROP SEQUENCE SEQ_Members_memberNo;
DROP SEQUENCE SEQ_Members_UserNo;




/* Create Sequences */

CREATE SEQUENCE SEQ_Gallery_GalleryPostNo INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Members_UserNo INCREMENT BY 1 START WITH 1;



/* Create Tables */

-- 사진게시판
CREATE TABLE Gallery
(
	-- 사진게시판 게시물 번호
	GalleryPostNo number NOT NULL,
	-- 유저아이디
	Id varchar2(20) NOT NULL UNIQUE,
	-- 게시물 제목
	title varchar2(100) NOT NULL,
	-- 게시물 내용
	content varchar2(2000 char) NOT NULL,
	-- 게시물 등록일
	postdate date default on null sysdate NOT NULL,
	-- 기존파일명
	ofile varchar2(100),
	-- 새로운 파일명 : 저장된 데이터의 이름 중복을 방지하기위함.
	nfile varchar2(50),
	-- 다운로드 수
	downcount number DEFAULT 0 NOT NULL,
	-- 조회수
	visitcount number DEFAULT 0 NOT NULL,
	-- 카테고리 : 일반 혹은 공지
	cate varchar2(30) NOT NULL,
	PRIMARY KEY (GalleryPostNo)
);


-- 유저 DB
CREATE TABLE Members
(
	-- 고유 유저번호
	UserNo number NOT NULL,
	-- 유저아이디
	Id varchar2(20) NOT NULL UNIQUE,
	-- 유저 패스워드
	pass varchar2(200) NOT NULL,
	-- 유저 성함
	name varchar2(20) NOT NULL,
	-- 유저 닉네임
	nickname varchar2(16) UNIQUE,
	-- 유저 이메일
	email varchar2(50),
	-- 유저 기본주소
	adress1 varchar2(200),
	-- 유저 상세주소
	adress2 varchar2(200),
	-- gender
	gender varchar2(4),
	-- Birth
	Birth varchar2(10 char),
	-- 회원가입일
	regidate date default on null sysdate NOT NULL,
	-- 유저 전화번호
	phonenumber varchar2(30),
	PRIMARY KEY (UserNo, Id)
);



/* Create Foreign Keys */

ALTER TABLE Gallery
	ADD FOREIGN KEY (Id)
	REFERENCES Members (Id)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_Gallery_GalleryPostNo BEFORE INSERT ON Gallery
FOR EACH ROW
BEGIN
	SELECT SEQ_Gallery_GalleryPostNo.nextval
	INTO :new.GalleryPostNo
	FROM dual;
END;

/


CREATE OR REPLACE TRIGGER TRI_Members_UserNo BEFORE INSERT ON Members
FOR EACH ROW
BEGIN
	SELECT SEQ_Members_UserNo.nextval
	INTO :new.UserNo
	FROM dual;
END;

/




/* Comments */

COMMENT ON TABLE Gallery IS '사진게시판';
COMMENT ON COLUMN Gallery.GalleryPostNo IS '사진게시판 게시물 번호';
COMMENT ON COLUMN Gallery.Id IS '유저아이디';
COMMENT ON COLUMN Gallery.title IS '게시물 제목';
COMMENT ON COLUMN Gallery.content IS '게시물 내용';
COMMENT ON COLUMN Gallery.postdate IS '게시물 등록일';
COMMENT ON COLUMN Gallery.ofile IS '기존파일명';
COMMENT ON COLUMN Gallery.nfile IS '새로운 파일명 : 저장된 데이터의 이름 중복을 방지하기위함.';
COMMENT ON COLUMN Gallery.downcount IS '다운로드 수';
COMMENT ON COLUMN Gallery.visitcount IS '조회수';
COMMENT ON COLUMN Gallery.cate IS '카테고리 : 일반 혹은 공지';
COMMENT ON TABLE Members IS '유저 DB';
COMMENT ON COLUMN Members.UserNo IS '고유 유저번호';
COMMENT ON COLUMN Members.Id IS '유저아이디';
COMMENT ON COLUMN Members.pass IS '유저 패스워드';
COMMENT ON COLUMN Members.name IS '유저 성함';
COMMENT ON COLUMN Members.nickname IS '유저 닉네임';
COMMENT ON COLUMN Members.email IS '유저 이메일';
COMMENT ON COLUMN Members.adress1 IS '유저 기본주소';
COMMENT ON COLUMN Members.adress2 IS '유저 상세주소';
COMMENT ON COLUMN Members.gender IS 'gender';
COMMENT ON COLUMN Members.Birth IS 'Birth';
COMMENT ON COLUMN Members.regidate IS '회원가입일';
COMMENT ON COLUMN Members.phonenumber IS '유저 전화번호';

insert into members values ('','admin','1234','관리자','주인장','admin@naver.com','','','','','','');


commit;