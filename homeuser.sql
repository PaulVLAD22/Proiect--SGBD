 -- CREATING TABLES

drop table title cascade constraints;
drop table author cascade constraints;
drop table member cascade constraints;
drop table rental cascade constraints;
drop table title_author cascade constraints;
drop table copy_title cascade constraints;
drop table address cascade constraints;
drop table transaction cascade constraints;

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

CREATE TABLE audit_user(
  nume_bd VARCHAR2(50),
  user_logat VARCHAR2(30),
  eveniment VARCHAR2(20),
  tip_obiect_referit VARCHAR2(30),
  nume_obiect_referit VARCHAR2(30),
  data TIMESTAMP(3)
);

CREATE TABLE title (
  title_id NUMBER(10) CONSTRAINT title_pk PRIMARY KEY,
  description varchar2(128),
  rating NUMBER(3),
  category varchar2(10),
  release_date date,
  price_per_day NUMBER(3)
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
  phone_number varchar2(20) constraint member_phone_number_nn NOT NULL,
  join_date date constraint member_join_date_nn NOT NULL,
  balance number(10) default 0
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
  act_ret_date date default null,
  exp_ret_date date,
  CONSTRAINT rental_pk PRIMARY KEY (rental_id)
);
CREATE TABLE transaction(
  transaction_id number(10),
  member_id constraint transaction_member_id_fk references member(member_id) on delete cascade,
  transcation_description varchar2(128),
  constraint transaction_pk primary key (transaction_id)
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
drop sequence seq_rental;
drop sequence seq_address;
drop sequence seq_transaction;

-- create sequences
CREATE SEQUENCE seq_author MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_title MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_member MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_copy_title MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_address MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_rental MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_transaction MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
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
INSERT INTO author VALUES (seq_author.nextval,'Mircea','Eliade');

INSERT INTO title VALUES (seq_title.nextval,'Hunting Bears',65,'Hunting',TO_DATE('2020-03-20','YYYY-MM-DD'),2);
INSERT INTO title VALUES (seq_title.nextval,'Cooking Vegan Food',89,'Cooking',TO_DATE('2015-01-25','YYYY-MM-DD'),7);
INSERT INTO title VALUES (seq_title.nextval,'Using javascript in programming',65,'IT',TO_DATE('2010-04-02','YYYY-MM-DD'),9);
INSERT INTO title VALUES (seq_title.nextval,'Using c++ in programming',40,'IT',TO_DATE('2005-01-01','YYYY-MM-DD'),9);
INSERT INTO title VALUES (seq_title.nextval,'Using java in programming',50,'IT',TO_DATE('2016-01-03','YYYY-MM-DD'),9);
INSERT INTO title VALUES (seq_title.nextval,'Using python in programming',75,'IT',TO_DATE('2019-04-02','YYYY-MM-DD'),9);
INSERT INTO title VALUES (seq_title.nextval,'Philosphy Starter Pack',80,'Philosophy',TO_DATE('2017-12-15','YYYY-MM-DD'),9);
INSERT INTO title VALUES (seq_title.nextval,'Cooking Desserts',50,'Cooking',TO_DATE('2012-01-25','YYYY-MM-DD'),8);
INSERT INTO title VALUES (seq_title.nextval,'Surviving on an island',65,'Survival',TO_DATE('2020-01-12','YYYY-MM-DD'),3);
INSERT INTO title VALUES (seq_title.nextval,'Poetry in Mihai Eminescu Style',89,'Poetry',TO_DATE('2000-02-10','YYYY-MM-DD'),2);

INSERT INTO member (member_id,first_name,last_name,address_id,phone_number,join_date) VALUES (seq_member.nextval,'Cezara','Grigoras',1,'0727587574',SYSDATE);
INSERT INTO member (member_id,first_name,last_name,address_id,phone_number,join_date) VALUES (seq_member.nextval,'Gabi','Flavius',2,'0721341296',TO_DATE('2010-04-02','YYYY-MM-DD'));
INSERT INTO member (member_id,first_name,last_name,address_id,phone_number,join_date) VALUES (seq_member.nextval,'Edi','Sujon',2,'0761413122',TO_DATE('2015-06-15','YYYY-MM-DD'));
INSERT INTO member (member_id,first_name,last_name,address_id,phone_number,join_date) VALUES (seq_member.nextval,'Mario','Marian',3,'02313133',SYSDATE);

INSERT INTO copy_title values (seq_copy_title.nextval,22);
INSERT INTO copy_title values (seq_copy_title.nextval,23);
INSERT INTO copy_title values (seq_copy_title.nextval,24);
INSERT INTO copy_title values (seq_copy_title.nextval,25);
INSERT INTO copy_title values (seq_copy_title.nextval,26);
INSERT INTO copy_title values (seq_copy_title.nextval,27);
INSERT INTO copy_title values (seq_copy_title.nextval,30);
INSERT INTO copy_title values (seq_copy_title.nextval,25);
INSERT INTO copy_title values (seq_copy_title.nextval,30);
INSERT INTO copy_title values (seq_copy_title.nextval,30);
INSERT INTO copy_title values (seq_copy_title.nextval,25);
INSERT INTO copy_title values (seq_copy_title.nextval,26);

INSERT INTO title_author values (21,1);
INSERT INTO title_author values (22,2);
INSERT INTO title_author values (23,3);
INSERT INTO title_author values (24,4);
INSERT INTO title_author values (25,5);
INSERT INTO title_author values (26,3);
INSERT INTO title_author values (27,4);
INSERT INTO title_author values (28,4);
INSERT INTO title_author values (29,4);
INSERT INTO title_author values (30,5);

INSERT INTO rental values (seq_rental.nextval,SYSDATE,1,8,TO_DATE('2020-11-15','YYYY-MM-DD'),TO_DATE('2020-11-10','YYYY-MM-DD'));
INSERT INTO rental values (seq_rental.nextval,TO_DATE('2019-05-02','YYYY-MM-DD'),5,8,SYSDATE,TO_DATE('2019-12-15','YYYY-MM-DD'));
INSERT INTO rental values (seq_rental.nextval,TO_DATE('2020-01-05','YYYY-MM-DD'),6,5,TO_DATE('2020-12-10','YYYY-MM-DD'),SYSDATE);
INSERT INTO rental (rental_id,book_date,copy_id,member_id,exp_ret_date) values (seq_rental.nextval,SYSDATE,4,7,TO_DATE('2021-01-10','YYYY-MM-DD'));

INSERT INTO address values (seq_address.nextval,'Bucharest','Ion Mihalache');
INSERT INTO address (address_id,city) values (seq_address.nextval,'Bucharest');
INSERT INTO address values (seq_address.nextval,'Cluj','Nicolae Grigorescu');
INSERT INTO address values (seq_address.nextval,'Constanta','Ion Mihalache');
INSERT INTO address (address_id,city) values (seq_address.nextval,'Brasov');

insert into transaction values (seq_transaction.nextval,5,'Member rented copy 1 of title 10');
insert into transaction values (seq_transaction.nextval,6,'Member rented copy 1 of title 10');
insert into transaction values (seq_transaction.nextval,7,'Member rented copy 1 of title 10');



-- 6. 
-- functie care returneaza id-ul copiilor care sunt in momentul asta inchiriate
create or replace type copies is table of number;

create or replace function showRented
return copies
is
    v_returned copies :=copies();
    v_numarCopii number:=0;
begin
    select count(*)
    into v_numarCopii
    from rental
    where act_ret_date is null;
    if (v_numarCopii=0) then
            raise_application_error(-20001,'Nu exista copii imprumutate.');
    else
    
        select copy_id
        bulk collect into v_returned
        from rental
        where act_ret_date is null;
        return v_returned;
    end if;
end;

select showRented
from dual;


create or replace type nume_carti is table of varchar;
--7 cartile scrise de un autor care sunt in categoria IT
create or replace function return_carti_IT (id_author in author.author_id%type)
return nume_carti
is
    return_nume_carti nume_carti := nume_carti();
    v_nrOfRows number;
    cursor c is 
    
    select t.description 
    from title t, title_author ta
    where id_author=ta.author_id
    and ta.title_id=t.title_id
    and t.category ='IT';
begin
    select count(*)
    into v_nrOfRows
    from author 
    where author_id=id_author;
    
    if (v_nrOfRows = 0) then
        raise_application_error(-20001,'Nu exista autorul.');
    else
        OPEN c;
        FETCH c BULK COLLECT INTO return_nume_carti;
        CLOSE c;
        return return_nume_carti;
    end if;
end;

select return_carti_IT(5)
from dual;

--8 functie pentru returnatCarti ce returneaza balance-ul membrul care a adus cartea.
create or replace function returnBook (id_title in title.title_id%type,id_member in member.member_id%type)
return varchar
is  
    v_nrOfRows number;
    v_returnPermis number:=1;
    v_nrCopie number :=-1;
    v_balance number;
    
    v_exp_date rental.exp_ret_date%type;
    v_book_date rental.book_date%type;
    v_price_per_day title.price_per_day%type;
begin
    --verificam titlul
    select count(*)
    into v_nrOfRows
    from title
    where title_id=id_title;
    if (v_nrOfRows !=1) then
        v_returnPermis:=0;
    end if;
    --verificam ca membrul sa fie corect
    select count(*)
    into v_nrOfRows
    from member
    where member_id=id_member;
    if (v_nrOfRows !=1) then
        v_returnPermis:=0;
    end if;
    if (v_returnPermis=0)then
        raise_application_error(-20001,'Id titlu sau membru gresit.');  
    else
        select count(*)
        into v_nrOfRows
        from rental
        where act_ret_date is null
        and member_id=id_member
        and copy_id in (select copy_id 
                        from copy_title
                        where title_id=id_title);
        
        if (v_nrOfRows=0) then
            raise_application_error(-20001,'Nicio copie imprumutata'); 
        else 
            select exp_ret_date,book_date,copy_id
            into v_exp_date,v_book_date,v_nrCopie
            from rental
            where member_id=id_member
            and act_ret_date is null
            and copy_id in (select copy_id
                            from copy_title
                            where title_id=id_title);
        
            select price_per_day
            into v_price_per_day
            from title
            where title_id=id_title;
            
            update rental 
            set act_ret_date=sysdate
            where member_id=id_member
            and act_ret_date is null
            and copy_id in (select copy_id
                            from copy_title
                            where title_id=id_title);
            
            update member
                set balance = balance+ v_price_per_day*(v_exp_date-v_book_date);
            if (sysdate>v_exp_date) then 
                update member
                set balance = balance - v_price_per_day*(sysdate-v_exp_date);
            end if;
            select balance 
            into v_balance
            from member
            where member_id=id_member;
            return 'New Balance is : '|| v_balance;
        end if;
    end if;
end;

select * from title;
select * from member;

begin
rent (30,6,30);
end;

begin
DBMS_OUTPUT.put_line(returnBook(28,8));
end;

select * from member;

begin
    DBMS_OUTPUT.put_line(returnBook(2,6));
end;
select * from rental;
select * from title;
select * from copy_title;



-- EX 9 title,copy title, rental, member, transiction
create or replace procedure rent (id_title in title.title_id%type,id_member in member.member_id%type,exp_days_rented in int)
is
    v_price title.price_per_day%type;
    type copies is table of copy_title.copy_id%type;
    t_copies copies;
    v_copy_to_give number :=-1;
    v_copy_ordered number :=1;
    
    v_nrOfRows number;
    v_rentPermis number:=1;
    
begin 
    --verificam titlul
    select count(*)
    into v_nrOfRows
    from title
    where title_id=id_title;
    if (v_nrOfRows !=1) then
        v_rentPermis:=0;
    end if;
    --verificam ca membrul sa fie corect
    select count(*)
    into v_nrOfRows
    from member
    where member_id=id_member;
    if (v_nrOfRows !=1) then
        v_rentPermis:=0;
    end if;
    if (v_rentPermis=1)then
    
        select copy_id
        bulk collect into t_copies
        from copy_title
        where title_id=id_title;
        
        for i in t_copies.first..t_copies.last
        loop
            v_copy_ordered:=1;
            select count(*)
            into v_copy_ordered
            from rental
            where 
            copy_id=t_copies(i)
            and
            act_ret_date is null;
            if (v_copy_ordered = 0) then 
                v_copy_to_give:=t_copies(i);
            end if;
        end loop;
        if (v_copy_to_give=-1) then
            raise_application_error(-20001,'Nu este valabila nicio copie');
        else
        
            insert into rental (rental_id,book_date,copy_id,member_id,exp_ret_date) values (seq_rental.nextval,sysdate,v_copy_to_give,id_member,sysdate+exp_days_rented);
            
            select price_per_day
            into v_price
            from title
            where title_id=id_title;
            
            update member
            set balance = balance - exp_days_rented*v_price
            where member_id = id_member;
            
            insert into transaction values (seq_transaction.nextval,id_member,'Member rented copy ' ||v_copy_to_give || ', copy of title with id : ' || id_title || '->' || ' -' || exp_days_rented*v_price);
        end if;
    else
    raise_application_error(-20001,'Id membru sau titlu gresit.');
    end if;
end;


BEGIN    
rent(28,8,20);
end;
select * from rental;

select * from copy_title;
select * from rental
where member_id=6;


--10 trigger la nivel de instructiune : nu se pot adauga copii decat intre orele 8-18

create or replace trigger ex_10
    before insert on copy_title
BEGIN
    if (TO_CHAR(SYSDATE,'D') =1)
        OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 8 AND 17)
    THEN
    raise_application_error(-20001,'Nu poti insera copii in afara orelor de munca');
    end if;
END;

begin 
    insert_copies(5,10);
end;

--11 trigger la nivel de linie

create or replace trigger ex_11
    after update of balance on member
    for each row
begin
    if (:NEW.balance < -500)
    then
    raise_application_error(-20001,'Datorii de peste 500 de lei.');
    end if;
end;
begin
rent(5,8,1000);
end;
--12 trigger LDD

create or replace trigger audit_schema
    AFTER CREATE OR DROP OR ALTER ON SCHEMA
    BEGIN
        INSERT INTO audit_user VALUES (SYS.DATABASE_NAME, SYS.LOGIN_USER, SYS.SYSEVENT, SYS.DICTIONARY_OBJ_TYPE,SYS.DICTIONARY_OBJ_NAME, SYSTIMESTAMP(3));
    END;
--13

create or replace package proiectSGBD as
    type copies is table of number;
    type grup_autori is table of number;
    type nume_carti is table of varchar2(128);
     
    function showRented return copies;
    function return_carti_IT (id_author in author.author_id%type) return nume_carti;
    function returnBook (id_title in title.title_id%type,id_member in member.member_id%type) return varchar;
    procedure rent (id_title in title.title_id%type,id_member in member.member_id%type,exp_days_rented in int);
    procedure insert_copies (copy_nr in number,id_title in title.title_id%type);
    procedure addBalance (id_member in member.member_id%type,value_added in number);
    function viewBalance (id_member in member.member_id%type) return number;
    procedure createMember (name_first in varchar2,name_last in varchar2,phone in varchar2,p_city in varchar2,name_street in varchar2);
    function memberExists(name_first in varchar2,name_last in varchar2,phone in varchar2,p_city in varchar2,name_street in varchar2) return int;
    function getMemberId(name_first in varchar2,name_last in varchar2,phone in varchar2,p_city in varchar2,name_street in varchar2) return int;
    function getTitlesOfAuthor(id_author in number) return nume_carti;
    function getAuthorId(name_first in varchar2,name_last in varchar2) return grup_autori;

end proiectSGBD;

create or replace package body proiectSGBD as

function showRented 
return copies
is
    v_returned copies :=copies();
    v_numarCopii number:=0;
begin
    select count(*)
    into v_numarCopii
    from rental
    where act_ret_date is null;
    if (v_numarCopii=0) then
            raise_application_error(-20001,'Nu exista copii imprumutate.');
    else
    
        select copy_id
        bulk collect into v_returned
        from rental
        where act_ret_date is null;
        return v_returned;
    end if;
end;

function return_carti_IT (id_author in author.author_id%type)
return nume_carti
is
    return_nume_carti nume_carti := nume_carti();
    v_nrOfRows number;
    cursor c is 
    
    select t.description 
    from title t, title_author ta
    where id_author=ta.author_id
    and ta.title_id=t.title_id
    and t.category ='IT';
begin
    select count(*)
    into v_nrOfRows
    from author 
    where author_id=id_author;
    
    if (v_nrOfRows = 0) then
        raise_application_error(-20001,'Nu exista autorul.');
    else
        OPEN c;
        FETCH c BULK COLLECT INTO return_nume_carti;
        CLOSE c;
        return return_nume_carti;
    end if;
end;

function returnBook (id_title in title.title_id%type,id_member in member.member_id%type)
return varchar
is  
    v_nrOfRows number;
    v_returnPermis number:=1;
    v_nrCopie number :=-1;
    v_balance number;
    
    v_exp_date rental.exp_ret_date%type;
    v_book_date rental.book_date%type;
    v_price_per_day title.price_per_day%type;
begin
    --verificam titlul
    select count(*)
    into v_nrOfRows
    from title
    where title_id=id_title;
    if (v_nrOfRows !=1) then
        v_returnPermis:=0;
    end if;
    --verificam ca membrul sa fie corect
    select count(*)
    into v_nrOfRows
    from member
    where member_id=id_member;
    if (v_nrOfRows !=1) then
        v_returnPermis:=0;
    end if;
    if (v_returnPermis=0)then
        raise_application_error(-20001,'Id titlu sau membru gresit.');  
    else
        select count(*)
        into v_nrOfRows
        from rental
        where act_ret_date is null
        and member_id=id_member
        and copy_id in (select copy_id 
                        from copy_title
                        where title_id=id_title);
        
        if (v_nrOfRows=0) then
            raise_application_error(-20001,'Nicio copie imprumutata'); 
        else 
        
            select exp_ret_date,book_date,copy_id
            into v_exp_date,v_book_date,v_nrCopie
            from rental
            where member_id=id_member
            and act_ret_date is null
            and copy_id in (select copy_id
                            from copy_title
                            where title_id=id_title);
        
            select price_per_day
            into v_price_per_day
            from title
            where title_id=id_title;
            
            update rental 
            set act_ret_date=sysdate
            where member_id=id_member
            and act_ret_date is null
            and copy_id in (select copy_id
                            from copy_title
                            where title_id=id_title);
            
            update member
                set balance = balance+ v_price_per_day*(v_exp_date-v_book_date);
            if (sysdate>v_exp_date) then 
                update member
                set balance = balance - v_price_per_day*(sysdate-v_exp_date);
            end if;
            select balance 
            into v_balance
            from member
            where member_id=id_member;
            return 'New Balance is : '|| v_balance;
        end if;
    end if;
end;

procedure rent (id_title in title.title_id%type,id_member in member.member_id%type,exp_days_rented in int)
is
    v_price title.price_per_day%type;
    type copies is table of copy_title.copy_id%type;
    t_copies copies;
    v_copy_to_give number :=-1;
    v_copy_ordered number :=1;
    
    v_nrOfRows number;
    v_rentPermis number:=1;
    
begin 
    --verificam titlul
    select count(*)
    into v_nrOfRows
    from title
    where title_id=id_title;
    if (v_nrOfRows !=1) then
        v_rentPermis:=0;
    end if;
    --verificam ca membrul sa fie corect
    select count(*)
    into v_nrOfRows
    from member
    where member_id=id_member;
    if (v_nrOfRows !=1) then
        v_rentPermis:=0;
    end if;
    if (v_rentPermis=1)then
    
        select copy_id
        bulk collect into t_copies
        from copy_title
        where title_id=id_title;
        
        for i in t_copies.first..t_copies.last
        loop
            v_copy_ordered:=1;
            select count(*)
            into v_copy_ordered
            from rental
            where 
            copy_id=t_copies(i)
            and
            act_ret_date is null;
            if (v_copy_ordered = 0) then 
                v_copy_to_give:=t_copies(i);
            end if;
        end loop;
        if (v_copy_to_give=-1) then
            raise_application_error(-20001,'Nu este valabila nicio copie');
        else
        
            insert into rental (rental_id,book_date,copy_id,member_id,exp_ret_date) values (seq_rental.nextval,sysdate,v_copy_to_give,id_member,sysdate+exp_days_rented);
            
            select price_per_day
            into v_price
            from title
            where title_id=id_title;
            
            update member
            set balance = balance - exp_days_rented*v_price
            where member_id = id_member;
            
            insert into transaction values (seq_transaction.nextval,id_member,'Member rented copy ' ||v_copy_to_give || ', copy of title with id : ' || id_title || '->' || ' -' || exp_days_rented*v_price);
        end if;
    else
    raise_application_error(-20001,'Id membru sau titlu gresit.');
    end if;
end;

 procedure insert_copies (copy_nr in number,id_title in title.title_id%type)
is 
begin
    for i in 1..copy_nr
    loop
    INSERT INTO copy_title values (seq_copy_title.nextval,id_title);
    end loop;
end;

procedure addBalance (id_member in member.member_id%type,value_added in number)
is
begin
    update member
    set balance=balance+value_added
    where member_id=id_member;
end;

function viewBalance (id_member in member.member_id%type)
return number
is
    v_balance number;
begin
    select balance
    into v_balance
    from member
    where member_id=id_member;
    return v_balance;
end;

procedure createMember (name_first in varchar2,name_last in varchar2,phone in varchar2,p_city in varchar2,name_street in varchar2)
is
    v_address_id number :=-1;
begin
    if (memberExists(name_first,name_last,phone,p_city,name_street)=0) then
    select address_id
    into v_address_id
    from address
    where city=p_city
    and street_name=name_street;
    if (v_address_id = -1) then
        v_address_id:=seq_address.nextval;
        insert into address values (v_address_id,p_city,name_street);
        insert into member (member_id,first_name,last_name,address_id,phone_number,join_date) values (seq_member.nextval,name_first,name_last,v_address_id,phone,Sysdate);
    else
        insert into member (member_id,first_name,last_name,address_id,phone_number,join_date) values (seq_member.nextval,name_first,name_last,v_address_id,phone,Sysdate);
    end if;
    DBMS_OUTPUT.put_line('Member added');
    else
    DBMS_OUTPUT.put_line('Member already exists');
    end if;
end;

function memberExists(name_first in varchar2,name_last in varchar2,phone in varchar2,p_city in varchar2,name_street in varchar2)
return int
is
    v_exists int;
    v_address_id number :=-1;
    v_member_id number :=-1;
begin
    select count(*)
    into v_address_id
    from address
    where city=p_city
    and street_name=name_street;
    if (v_address_id =-1) then
    return 0;
    else
        select count(*)
        into v_member_id
        from member
        where first_name=name_first
        and last_name=name_last
        and phone_number=phone;
        if (v_member_id=-1) then
        return 0;
        else 
        return v_member_id;
        end if;
    end if;
end;

function getMemberId(name_first in varchar2,name_last in varchar2,phone in varchar2,p_city in varchar2,name_street in varchar2)
return int
is
    v_member_id number ;
    v_address_id number;
begin
    if (memberExists(name_first,name_last,phone,p_city,name_street)=1) then
        select address_id
        into v_address_id
        from address
        where city=p_city 
        and street_name=name_street;
        select member_id
        into v_member_id
        from member
        where first_name=name_first
        and last_name=name_last
        and address_id=v_address_id
        and phone_number=phone;
        return v_member_id;
    else
    return -1;
    end if;
end;

function getAuthorId(name_first in varchar2,name_last in varchar2)
return grup_autori
is
    v_autori grup_autori := grup_autori();
begin
    select author_id
    bulk collect into v_autori
    from author
    where first_name=name_first
    and last_name=name_last;
    return v_autori;
end;

function getTitlesOfAuthor(id_author in number)
return nume_carti
is 
    v_return nume_carti := nume_carti();
begin
    select description
    bulk collect into v_return
    from title t,title_author ta
    where t.title_id=ta.title_id
    and ta.author_id=id_author;
    return v_return;
end;


end proiectSGBD;
    

-- pentru utilitatea librariei

--procedura de inserat x copii pt titlu y

create or replace procedure insert_copies (copy_nr in number,id_title in title.title_id%type)
is 
begin
    for i in 1..copy_nr
    loop
    INSERT INTO copy_title values (seq_copy_title.nextval,id_title);
    end loop;
end;



--adauga balance
create or replace procedure addBalance (id_member in member.member_id%type,value_added in number)
is
begin
    update member
    set balance=balance+value_added
    where member_id=id_member;
end;
-- view balance
create or replace function viewBalance (id_member in member.member_id%type)
return number
is
    v_balance number;
begin
    select balance
    into v_balance
    from member
    where member_id=id_member;
    return v_balance;
end;

--functie pentru adaugare membrii

create or replace procedure createMember (name_first in varchar2,name_last in varchar2,phone in varchar2,p_city in varchar2,name_street in varchar2)
is
    v_address_id number :=-1;
begin
    if (memberExists(name_first,name_last,phone,p_city,name_street)=0) then
    select address_id
    into v_address_id
    from address
    where city=p_city
    and street_name=name_street;
    if (v_address_id = -1) then
        v_address_id:=seq_address.nextval;
        insert into address values (v_address_id,p_city,name_street);
        insert into member (member_id,first_name,last_name,address_id,phone_number,join_date) values (seq_member.nextval,name_first,name_last,v_address_id,phone,Sysdate);
    else
        insert into member (member_id,first_name,last_name,address_id,phone_number,join_date) values (seq_member.nextval,name_first,name_last,v_address_id,phone,Sysdate);
    end if;
    DBMS_OUTPUT.put_line('Member added');
    else
    DBMS_OUTPUT.put_line('Member already exists');
    end if;
end;

-- verifica daca exista membru inainte sa l bagam sau daca ma intreaba clent
create or replace function memberExists(name_first in varchar2,name_last in varchar2,phone in varchar2,p_city in varchar2,name_street in varchar2)
return int
is
    v_exists int;
    v_address_id number :=-1;
    v_member_id number :=-1;
begin
    select count(*)
    into v_address_id
    from address
    where city=p_city
    and street_name=name_street;
    if (v_address_id =-1) then
    return 0;
    else
        select count(*)
        into v_member_id
        from member
        where first_name=name_first
        and last_name=name_last
        and phone_number=phone;
        if (v_member_id=-1) then
        return 0;
        else 
        return v_member_id;
        end if;
    end if;
end;
select * from member;
select * from address;

begin
createMember('Cezara','Grigoras','0727587574','Bucharest','Ion Mihalache');
end;

-- get memberid cand a uitat contul
create or replace function getMemberId(name_first in varchar2,name_last in varchar2,phone in varchar2,p_city in varchar2,name_street in varchar2)
return int
is
    v_member_id number ;
    v_address_id number;
begin
    if (memberExists(name_first,name_last,phone,p_city,name_street)=1) then
        select address_id
        into v_address_id
        from address
        where city=p_city 
        and street_name=name_street;
        select member_id
        into v_member_id
        from member
        where first_name=name_first
        and last_name=name_last
        and address_id=v_address_id
        and phone_number=phone;
        return v_member_id;
    else
    return -1;
    end if;
end;


create or replace type grup_autori is table of number;
create or replace type nume_carti is table of varchar2(128);
create or replace function getAuthorId(name_first in varchar2,name_last in varchar2)
return grup_autori
is
    v_autori grup_autori := grup_autori();
begin
    select author_id
    bulk collect into v_autori
    from author
    where first_name=name_first
    and last_name=name_last;
    return v_autori;
end;

create or replace function getTitlesOfAuthor(id_author in number)
return nume_carti
is 
    v_return nume_carti := nume_carti();
begin
    select description
    bulk collect into v_return
    from title t,title_author ta
    where t.title_id=ta.title_id
    and ta.author_id=id_author;
    return v_return;
end;


-- rulare pachet

declare
     copii copies:=copies();
begin
 copii:=proiectSGBD.showRented;
end;

select proiectSGBD.return_carti_IT(5)
from dual

select * 
from rental
where act_ret_date is null;

begin
DBMS_OUTPUT.put_line(proiectSGBD.returnBook(25,5));
end;

-- ruleaza mia intai rent 
begin
proiectSGBD.rent (25,5,50);
end;

execute proiectSGBD.insert_copies(10,28);
select * from copy_title;


--pana aici sunt cele din ceri
--recompileaza
--ALTER PROCEDURE nume_procedura COMPILE;

begin
proiectSGBD.createMember('Vlad','Munteanu','0727587574','Brasov','Ion Mihalache');
end;

begin
DBMS_OUTPUT.put_line(proiectSGBD.memberExists('Vlad','Munteanu','0727587574','Brasov','Ion Mihalache'));
end;

-- fa cerere de marire si adauga : triggeri mai grei 

