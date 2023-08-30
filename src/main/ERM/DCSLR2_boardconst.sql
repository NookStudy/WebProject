

/* Drop Triggers */

DROP TRIGGER TRI_GALLERY_GallNo;
DROP TRIGGER TRI_MEMBERS_USERNO;
DROP TRIGGER TRI_NoticeBoard_NotiNo;
drop trigger


/* Drop Tables */
drop TABLE DCSLR.Hearts CASCADE CONSTRAINTS;
DROP TABLE DCSLR.GALLERY CASCADE CONSTRAINTS;
DROP TABLE DCSLR.NoticeBoard CASCADE CONSTRAINTS;
DROP TABLE DCSLR.MEMBERS CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_GALLERY_GallNo;
DROP SEQUENCE SEQ_MEMBERS_USERNO;
DROP SEQUENCE SEQ_NoticeBoard_NotiNo;
DROP SEQUENCE SEQ_Heart_HeartNo;



/* Create Sequences */

CREATE SEQUENCE SEQ_GALLERY_GallNo INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_MEMBERS_USERNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_NoticeBoard_NotiNo INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Heart_HeartNo INCREMENT BY 1 START WITH 1;


/* Create Tables */

-- 사진게시판
CREATE TABLE DCSLR.GALLERY
(
	-- 사진게시판 게시물 번호
	GallNo number NOT NULL,
	-- 유저아이디
	ID varchar2(20 char) NOT NULL ,
	-- 유저 닉네임
	nickname varchar2(16 char) not null,
	-- 게시물 제목
	TITLE varchar2(100 char) NOT NULL,
	-- 게시물 내용
	CONTENT varchar2(2000) NOT NULL,
	-- 게시물 등록일
	POSTDATE date DEFAULT on null sysdate  NOT NULL,
	-- 기존파일명
	OFILE varchar2(100 char),
	-- 새로운 파일명 : 저장된 데이터의 이름 중복을 방지하기위함.
	NFILE varchar2(50 char),
	-- 다운로드 수
	DOWNCOUNT number DEFAULT 0  NOT NULL,
	-- 조회수
	VISITCOUNT number DEFAULT 0  NOT NULL,
	-- 카테고리 : 일반 혹은 공지
	CATE varchar2(30 char) NOT NULL,
	CONSTRAINT GallPrime PRIMARY KEY (GallNo)
);
--좋아요 게시판
create table DCSLR.hearts
(
    ID varchar2(20 char) NOT NULL ,  
    GallNo number NOT NULL,
    heartno number not null,
   
    CONSTRAINT HeartPrime PRIMARY KEY (heartno)
);    
-- 유저 DB
CREATE TABLE DCSLR.MEMBERS
(
	-- 고유 유저번호
	USERNO number NOT NULL,
	-- 유저아이디
	ID varchar2(20 char) NOT NULL UNIQUE,
	-- 유저 패스워드
	PASS varchar2(200 char) NOT NULL,
	-- 유저 성함
	NAME varchar2(20 char) NOT NULL,
	-- 유저 닉네임
	NICKNAME varchar2(16 char) UNIQUE,
	-- 유저 이메일
	EMAIL varchar2(50 char),
	-- 유저 기본주소
	ADRESS1 varchar2(200 char),
	-- 유저 상세주소
	ADRESS2 varchar2(200 char),
	-- gender
	GENDER varchar2(4 char),
	-- Birth
	BIRTH varchar2(10),
	-- 회원가입일
	REGIDATE date DEFAULT on null sysdate  NOT NULL,
	-- 유저 전화번호
	PHONENUMBER varchar2(30 char),
	CONSTRAINT MemPrime PRIMARY KEY (USERNO, ID)
);


-- 사진게시판
CREATE TABLE DCSLR.NoticeBoard
(
	NotiNo number NOT NULL,
	-- 유저아이디
	ID varchar2(20 char) NOT NULL,
	-- 유저 닉네임
	nickname varchar2(16 char) not null,
	-- 게시물 제목
	TITLE varchar2(100 char) NOT NULL,
	-- 게시물 내용
	CONTENT varchar2(2000) NOT NULL,
	-- 게시물 등록일
	POSTDATE date DEFAULT on null sysdate  NOT NULL,
	-- 기존파일명
	OFILE varchar2(100 char),
	-- 새로운 파일명 : 저장된 데이터의 이름 중복을 방지하기위함.
	NFILE varchar2(50 char),
	-- 다운로드 수
	DOWNCOUNT number DEFAULT on null 0  NOT NULL,
	-- 조회수
	VISITCOUNT number DEFAULT on null 0  NOT NULL,
	-- 카테고리 : 일반 혹은 공지
	CATE varchar2(30 char) default on null 'common' NOT NULL,
	CONSTRAINT NotiPrime PRIMARY KEY (NotiNo)
);



/* Create Foreign Keys */
ALTER TABLE DCSLR.hearts
	ADD FOREIGN KEY (ID)
	REFERENCES DCSLR.MEMBERS (ID)
;
ALTER TABLE DCSLR.hearts
	ADD FOREIGN KEY (gallno)
	REFERENCES DCSLR.GALLERY (gallno)
;


ALTER TABLE DCSLR.GALLERY
	ADD FOREIGN KEY (ID)
	REFERENCES DCSLR.MEMBERS (ID)
;


ALTER TABLE DCSLR.GALLERY
	ADD FOREIGN KEY (nickname)
	REFERENCES DCSLR.MEMBERS (NICKNAME)
;


ALTER TABLE DCSLR.NoticeBoard
	ADD FOREIGN KEY (ID)
	REFERENCES DCSLR.MEMBERS (ID)
;


ALTER TABLE DCSLR.NoticeBoard
	ADD FOREIGN KEY (nickname)
	REFERENCES DCSLR.MEMBERS (NICKNAME)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_GALLERY_GallNo BEFORE INSERT ON GALLERY
FOR EACH ROW
BEGIN
	SELECT SEQ_GALLERY_GallNo.nextval
	INTO :new.GallNo
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_MEMBERS_USERNO BEFORE INSERT ON MEMBERS
FOR EACH ROW
BEGIN
	SELECT SEQ_MEMBERS_USERNO.nextval
	INTO :new.USERNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_NoticeBoard_NotiNo BEFORE INSERT ON NoticeBoard
FOR EACH ROW
BEGIN
	SELECT SEQ_NoticeBoard_NotiNo.nextval
	INTO :new.NotiNo
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_HEARTS_HeartNo BEFORE INSERT ON Hearts
FOR EACH ROW
BEGIN
	SELECT SEQ_Heart_HeartNo.nextval
	INTO :new.HeartNo
	FROM dual;
END;

/




/* Comments */

COMMENT ON TABLE DCSLR.GALLERY IS '사진게시판';
COMMENT ON COLUMN DCSLR.GALLERY.GallNo IS '사진게시판 게시물 번호';
COMMENT ON COLUMN DCSLR.GALLERY.ID IS '유저아이디';
COMMENT ON COLUMN DCSLR.GALLERY.nickname IS '유저 닉네임';
COMMENT ON COLUMN DCSLR.GALLERY.TITLE IS '게시물 제목';
COMMENT ON COLUMN DCSLR.GALLERY.CONTENT IS '게시물 내용';
COMMENT ON COLUMN DCSLR.GALLERY.POSTDATE IS '게시물 등록일';
COMMENT ON COLUMN DCSLR.GALLERY.OFILE IS '기존파일명';
COMMENT ON COLUMN DCSLR.GALLERY.NFILE IS '새로운 파일명 : 저장된 데이터의 이름 중복을 방지하기위함.';
COMMENT ON COLUMN DCSLR.GALLERY.DOWNCOUNT IS '다운로드 수';
COMMENT ON COLUMN DCSLR.GALLERY.VISITCOUNT IS '조회수';
COMMENT ON COLUMN DCSLR.GALLERY.CATE IS '카테고리 : 일반 혹은 공지';
COMMENT ON TABLE DCSLR.MEMBERS IS '유저 DB';
COMMENT ON COLUMN DCSLR.MEMBERS.USERNO IS '고유 유저번호';
COMMENT ON COLUMN DCSLR.MEMBERS.ID IS '유저아이디';
COMMENT ON COLUMN DCSLR.MEMBERS.PASS IS '유저 패스워드';
COMMENT ON COLUMN DCSLR.MEMBERS.NAME IS '유저 성함';
COMMENT ON COLUMN DCSLR.MEMBERS.NICKNAME IS '유저 닉네임';
COMMENT ON COLUMN DCSLR.MEMBERS.EMAIL IS '유저 이메일';
COMMENT ON COLUMN DCSLR.MEMBERS.ADRESS1 IS '유저 기본주소';
COMMENT ON COLUMN DCSLR.MEMBERS.ADRESS2 IS '유저 상세주소';
COMMENT ON COLUMN DCSLR.MEMBERS.GENDER IS 'gender';
COMMENT ON COLUMN DCSLR.MEMBERS.BIRTH IS 'Birth';
COMMENT ON COLUMN DCSLR.MEMBERS.REGIDATE IS '회원가입일';
COMMENT ON COLUMN DCSLR.MEMBERS.PHONENUMBER IS '유저 전화번호';
COMMENT ON TABLE DCSLR.NoticeBoard IS '사진게시판';
COMMENT ON COLUMN DCSLR.NoticeBoard.ID IS '유저아이디';
COMMENT ON COLUMN DCSLR.NoticeBoard.nickname IS '유저 닉네임';
COMMENT ON COLUMN DCSLR.NoticeBoard.TITLE IS '게시물 제목';
COMMENT ON COLUMN DCSLR.NoticeBoard.CONTENT IS '게시물 내용';
COMMENT ON COLUMN DCSLR.NoticeBoard.POSTDATE IS '게시물 등록일';
COMMENT ON COLUMN DCSLR.NoticeBoard.OFILE IS '기존파일명';
COMMENT ON COLUMN DCSLR.NoticeBoard.NFILE IS '새로운 파일명 : 저장된 데이터의 이름 중복을 방지하기위함.';
COMMENT ON COLUMN DCSLR.NoticeBoard.DOWNCOUNT IS '다운로드 수';
COMMENT ON COLUMN DCSLR.NoticeBoard.VISITCOUNT IS '조회수';
COMMENT ON COLUMN DCSLR.NoticeBoard.CATE IS '카테고리 : 일반 혹은 공지';

ALTER TABLE members ADD postcode VARCHAR(30);
alter table gallery add heart number default on null 0 not null;
--alter table gallery drop column heart;

insert into members(id,name,pass,nickname) values('admin','관리자','1234','주인장');
insert into noticeboard(id,nickname,title,content,cate) values('admin','주인장','첫번째 공지','내용은 없다','notice');
update noticeboard set visitcount = visitcount+1  where notino= 1; 
commit;



--purge recyclebin;
--select * from user_constraints;
