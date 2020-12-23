-- CREATING TABLES

drop table title cascade constraints;
drop table authors cascade constraints;
drop table member cascade constraints;
drop table rental cascade constraints;
drop table title_author_mapping cascade constraints;
drop table copy_title cascade constraints;

SELECT 
SYS_CONTEXT('USERENV','NLS_TERRITORY') nls_territory,
SYS_CONTEXT('USERENV','NLS_DATE_FORMAT') nls_date_format,
SYS_CONTEXT('USERENV','NLS_DATE_LANGUAGE') nls_date_language,
SYS_CONTEXT('USERENV','NLS_SORT') nls_sort, 
SYS_CONTEXT('USERENV','LANGUAGE') language
FROM DUAL;

select sysdate from dual;

alter session set NLS_LANGUAGE='AMERICAN';
alter session set NLS_TERRITORY='AMERICA';
alter session set NLS_DATE_LANGUAGE='AMERICAN';

PROMPT Please wait while tables are created.

CREATE TABLE title (
  title_id NUMBER(10) CONSTRAINT title_pk PRIMARY KEY,
  description varchar2(128),
  rating NUMBER(3),
  category varchar2(10),
  release_date date,
  price NUMBER(3)
);

CREATE TABLE author (
  author_id NUMBER(10)  CONSTRAINT author_pk PRIMARY KEY,
  first_name VARCHAR2(20) CONSTRAINT author_first_name_nn NOT NULL,
  last_name VARCHAR2(20) CONSTRAINT author_last_name_nn NOT NULL
);
CREATE TABLE title_author(
  title_id number(10) constraint title_author_title_fk REFERENCES title(title_id) ON DELETE CASCADE,
  author_id number(10) constraint title_author_author_fk REFERENCES author(author_id) ON DELETE CASCADE,
  CONSTRAINT title_author_pk PRIMARY KEY(title_id,author_id)
);
CREATE TABLE member(
  member_id number(10) constraint member_pk PRIMARY KEY,
  first_name varchar2(20) constraint member_first_name_nn NOT NULL,
  last_name varchar2(20) constraint member_last_name_nn NOT NULL,
  address_id number(10) constraint member_address_fk REFERENCES address(address_id) ON DELETE CASCADE,
  phone_number number(10) constraint member_phone_number_nn NOT NULL,
  join_date date constraint member_join_date_nn NOT NULL
);
CREATE TABLE address(
    address_id number(10) constraint address_pk PRIMARY KEY,
    city varchar2(20) constraint address_city_nn not null,
    street_name varchar2(40)
);
CREATE TABLE copy_title(
  copy_id number(10),
  title_id number(10) constraint copy_title_title_fk REFERENCES title(title_id) ON DELETE CASCADE,
  CONSTRAINT copy_title_pk PRIMARY KEY(copy_id)
);
CREATE TABLE rental(
  rental_id number(10),
  book_date date,
  copy_id  constraint rental_copy_id_fk REFERENCES copy_title(copy_id) ON DELETE CASCADE,
  member_id constraint rental_member_id_fk REFERENCES member(member_id) ON DELETE CASCADE,
  act_ret_date date,
  exp_ret_date date,
  CONSTRAINT rental_pk PRIMARY KEY (rental_id)
);


describe title;
PROMPT
describe author;
PROMPT
describe member;
PROMPT
describe rental;
PROMPT
describe title_author;
PROMPT
describe copy_title;
PROMPT
describe address;

--INSERTING VALUES

DELETE FROM title;
DELETE FROM author;
DELETE from rental;
DELETE from title_author;
DELETE from copy_tile;
DELETE from member;

DROP SEQUENCE seq_author;
DROP SEQUENCE seq_title;
DROP SEQUENCE seq_member;
DROP SEQUENCE seq_copy_title;

-- create sequences
CREATE SEQUENCE seq_author MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_title MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_member MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_copy_title MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_address MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_rental MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;

describe title;
PROMPT
describe author;
PROMPT
describe member;
PROMPT
describe rental;
PROMPT
describe title_author;
PROMPT
describe copy_title;

--inserts

INSERT INTO author VALUES (seq_author.nextval,'Vlad','Munteanu');
INSERT INTO author VALUES (seq_author.nextval,'Ion','Creanga');
INSERT INTO author VALUES (seq_author.nextval,'Mihai','Eminescu');
INSERT INTO author VALUES (seq_author.nextval,'Bill','Gates');
INSERT INTO author VALUES (seq_author.nextval,'Ion','Creanga');

INSERT INTO title VALUES (seq_title.nextval,'Hunting Bears',65,'Hunting',TO_DATE('2020-03-20','YYYY-MM-DD'),20);
INSERT INTO title VALUES (seq_title.nextval,'Cooking Vegan Food',89,'Cooking',TO_DATE('2015-01-25','YYYY-MM-DD'),70);
INSERT INTO title VALUES (seq_title.nextval,'Using javascript in programming',65,'IT',TO_DATE('2010-04-02','YYYY-MM-DD'),90);
INSERT INTO title VALUES (seq_title.nextval,'Using c++ in programming',40,'IT',TO_DATE('2005-01-01','YYYY-MM-DD'),91);
INSERT INTO title VALUES (seq_title.nextval,'Using java in programming',50,'IT',TO_DATE('2016-01-03','YYYY-MM-DD'),95);
INSERT INTO title VALUES (seq_title.nextval,'Using python in programming',75,'IT',TO_DATE('2019-04-02','YYYY-MM-DD'),90);
INSERT INTO title VALUES (seq_title.nextval,'Philosphy Starter Pack',80,'Philosophy',TO_DATE('2017-12-15','YYYY-MM-DD'),99);
INSERT INTO title VALUES (seq_title.nextval,'Cooking Desserts',50,'Cooking',TO_DATE('2012-01-25','YYYY-MM-DD'),80);
INSERT INTO title VALUES (seq_title.nextval,'Surviving on an island',65,'Survival',TO_DATE('2020-01-12','YYYY-MM-DD'),30);
INSERT INTO title VALUES (seq_title.nextval,'Poetry in Mihai Eminescu Style',89,'Poetry',TO_DATE('2000-02-10','YYYY-MM-DD'),99);

INSERT INTO member VALUES (seq_member.nextval,'Cezara','Grigoras',1,0727587574,SYSDATE);
INSERT INTO member VALUES (seq_member.nextval,'Gabi','Flavius',2,0721341296,TO_DATE('2010-04-02','YYYY-MM-DD'));
INSERT INTO member VALUES (seq_member.nextval,'Edi','Sujon',2,0761413122,TO_DATE('2015-06-15','YYYY-MM-DD'));
INSERT INTO member VALUES (seq_member.nextval,'Mario','Marian',3,02313133,SYSDATE);

INSERT INTO copy_title values (seq_copy_title.nextval,1);
INSERT INTO copy_title values (seq_copy_title.nextval,2);
INSERT INTO copy_title values (seq_copy_title.nextval,3);
INSERT INTO copy_title values (seq_copy_title.nextval,2);
INSERT INTO copy_title values (seq_copy_title.nextval,3);
INSERT INTO copy_title values (seq_copy_title.nextval,4);
INSERT INTO copy_title values (seq_copy_title.nextval,5);
INSERT INTO copy_title values (seq_copy_title.nextval,6);
INSERT INTO copy_title values (seq_copy_title.nextval,4);
INSERT INTO copy_title values (seq_copy_title.nextval,5);
INSERT INTO copy_title values (seq_copy_title.nextval,10);
INSERT INTO copy_title values (seq_copy_title.nextval,10);



INSERT INTO title_author values (1,1);
INSERT INTO title_author values (2,2);
INSERT INTO title_author values (3,3);
INSERT INTO title_author values (4,4);
INSERT INTO title_author values (5,5);
INSERT INTO title_author values (6,3);
INSERT INTO title_author values (7,4);
INSERT INTO title_author values (8,4);
INSERT INTO title_author values (9,4);
INSERT INTO title_author values (10,5);

INSERT INTO rental values (seq_rental.nextval,SYSDATE,1,7,TO_DATE('2020-11-15','YYYY-MM-DD'),TO_DATE('2020-11-10','YYYY-MM-DD'));
INSERT INTO rental values (seq_rental.nextval,TO_DATE('2019-05-02','YYYY-MM-DD'),2,8,SYSDATE,TO_DATE('2019-12-15','YYYY-MM-DD'));
INSERT INTO rental values (seq_rental.nextval,TO_DATE('2020-01-05','YYYY-MM-DD'),3,9,TO_DATE('2020-12-10','YYYY-MM-DD'),SYSDATE);
INSERT INTO rental (rental_id,book_date,copy_id,member_id,exp_ret_date) values (seq_rental.nextval,SYSDATE,4,10,TO_DATE('2021-01-10','YYYY-MM-DD'));

INSERT INTO address values (seq_address.nextval,'Bucharest','Ion Mihalache');
INSERT INTO address (address_id,city) values (seq_address.nextval,'Bucharest');
INSERT INTO address values (seq_address.nextval,'Cluj','Nicolae Grigorescu');
INSERT INTO address values (seq_address.nextval,'Constanta','Ion Mihalache');
INSERT INTO address (address_id,city) values (seq_address.nextval,'Brasov');




-- 6. 
create type nume_carti is table of varchar2(255);

--functie care returneaza toate cartile scrise de un autor prin id
create or replace function return_carti (id_author in author.author_id%type)
return nume_carti
is
    return_nume_carti nume_carti := nume_carti();
begin
    select t.description
    bulk collect into return_nume_carti
    from title t, title_author ta
    where id_author=ta.author_id
    and ta.title_id=t.title_id;
    
    return return_nume_carti;
end;

select return_carti(author_id)
from author 
where author_id=5;

--7 cartile scrise de autor prin id care sunt in categoria IT
create or replace function return_carti_IT (id_author in author.author_id%type)
return nume_carti
is
    return_nume_carti nume_carti := nume_carti();
    
    cursor c is 
    
    select t.description 
    from title t, title_author ta
    where id_author=ta.author_id
    and ta.title_id=t.title_id
    and t.category ='IT';
begin
    OPEN c;
    FETCH c BULK COLLECT INTO return_nume_carti;
    CLOSE c;
    return return_nume_carti;
end;

select return_carti_IT(author_id)
from author
where author_id=5;

--8 functie care returneaza numarul de copii a titlului cu cel mai mare rating al unui autor
create or replace function return_nr_copii (id_author in author.author_id%type)
return number
is
    return_numar_copii number;
begin
    select count(*)
    into return_numar_copii
    from copy_title ct
    where ct.title_id=(select t1.title_id
                    from author a,title t1,title_author ta1
                    where a.author_id=id_author
                    and ta1.author_id=a.author_id
                    and ta1.title_id=t1.title_id
                    and t1.rating=(select max(t2.rating)
                                 from title_author ta2,title t2
                                 where ta2.author_id=id_author
                                 and ta2.title_id=t2.title_id));
    return return_numar_copii;
end;

select return_nr_copii(author_id)
from author
where author_id=5;
-- DE FACUT EXCEPTIILE


--9 categoriile-titlurile pentru titlurile rent-uite de catre un membru care locuieste in oras dat
create or replace procedure displayCategories (given_city in address.city%type)
is 
    v_category title.category%type;
    v_description title.description%type;
    
    cursor c is
    select t.category,t.description
    from title t
    where t.title_id in(select title_id 
                        from copy_title ct
                        where ct.copy_id in (select r.copy_id 
                                            from rental r,member m
                                            where r.member_id=m.member_id
                                            and m.address_id in (select address_id
                                                                from address 
                                                                where city=given_city)));
begin
    open c;
    loop
        fetch c into v_category,v_description;
        exit when c%notfound;
        DBMS_OUTPUT.PUT_LINE('Categorie: '|| v_category || ' - Nume: '||v_description);
    end loop;
    close c;
end;


begin
    displayCategories('Bucharest');
end;

-- FA EXCEPTIILE POSIBILE


--ex 10