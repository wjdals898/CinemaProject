drop sequence users_seq;
drop sequence movies_seq;
drop sequence theaters_seq;
drop sequence reservations_seq;
drop sequence seats_seq;
drop table seats_reservations;
drop table reservations;
drop table seats;
drop table theaters;
drop table movies;
drop table users;

truncate table theaters;

---------------------------------------------
-- 테이블 생성
create table users(
    id number primary key,
    username varchar2(30) not null unique,
    password varchar2(30) not null,
    nickname varchar2(50) not null unique,
    phone varchar2(15),
    gender number(1),
    is_manager number(1) default 0
);

create table movies (
    id number primary key,
    title varchar2(100) not null,
    director varchar2(50) not null,
    content varchar2(300),
    running_time varchar2(20) not null,
    poster varchar2(200),
    theaters_count number default 0
);

create table theaters (
    id number primary key,
    movie_id number constraint theaters_movie_id_fk REFERENCES movies(id),
    screening_datetime DATE default sysdate,
    remaining_seats_count number default 0
);

alter table theaters add unique (screening_datetime);

create table reservations (
    id number primary key,
    user_id number constraint reservations_user_id_fk references users(id),
    theater_id number constraint reservations_theater_id_fk references theaters(id),
    reservation_date date default sysdate
);

create table seats (
    id number primary key,
    theater_id number constraint seats_theater_id_fk references theaters(id),
    seat_num varchar2(10) not null,
    is_soldout number(1) default 0
);

create table seats_reservations (
    reservation_id number constraint sr_reservation_id_fk references reservations(id),
    seat_id number constraint sr_seat_id_fk references seats(id)
);

--------------------------------------
-- 시퀀스 생성
create sequence users_seq;
create sequence movies_seq;
create sequence theaters_seq;
create sequence reservations_seq;
create sequence seats_seq;

------------------------------------
-- 프로시저
-- 상영관 추가시 자동으로 생성되는 좌석 리스트 --
create or replace procedure sp_seats(theater_id theaters.id%type, c number)
is
    seat_num varchar2(10);
begin
    for i in 1..c/10 loop
        if i = 1 then
            seat_num := 'a';
        elsif i = 2 then
            seat_num := 'b';
        elsif i = 3 then
            seat_num := 'c';
        elsif i = 4 then
            seat_num := 'd';
        elsif i = 5 then
            seat_num := 'e';
        elsif i = 6 then
            seat_num := 'f';
        end if;
        for j in 1..10 loop
            insert into seats values(seats_seq.nextval, theater_id, seat_num||to_char(j), 0);
        end loop;
    end loop;
end;
/

-- 영화, 상영관, 좌석 선택 후 예매시 예매 데이터 저장하고 예매번호 리턴
create or replace procedure sp_create_reservation(v_user_id users.id%type, v_theater_id theaters.id%type, v_reservation_id out reservations.id%type)
is
begin
    -- 예매 테이블에 데이터 삽입
    insert into reservations values(reservations_seq.nextval, v_user_id, v_theater_id, sysdate);
    
    select id into v_reservation_id
    from (
        select id
        from reservations
        where user_id = v_user_id and theater_id = v_theater_id
        order by reservation_date desc
    )
    where rownum = 1;
end;
/

-- 예매취소시 다시 해당 좌석 예매할 수 있도록 좌석 테이블 수정 / 좌석_예매, 예매 데이터 삭제
create or replace procedure sp_delete_reservation(v_reservation_id reservations.id%type)
is
begin
    -- 좌석 is_soldout 0으로 수정
    update seats
    set is_soldout = 0
    where id in (select seat_id from seats_reservations where reservation_id = v_reservation_id);
    
    -- 좌석_예매 테이블 데이터 삭제
    delete from seats_reservations where reservation_id = v_reservation_id;    
    
    -- 예매 테이블 데이터 삭제
    delete from reservations where id = v_reservation_id;
end;
/

-- 예매시 선택한 좌석 다시 예매할 수 없도록 좌석 데이터 수정 / 좌석_예매 테이블 데이터 저장
create or replace procedure sp_seat_reservation(v_reservation_id reservations.id%type, v_seat_id seats.id%type)
is
begin
    -- 좌석 테이블에 선택한 좌석 soldout 처리
    update seats
    set is_soldout = 1
    where id = v_seat_id;
    
    -- 좌석_예매 테이블에 데이터 삽입
    insert into seats_reservations values(v_reservation_id, v_seat_id);
end;
/

-----------------------------------------------------
-- 트리거 생성

-- 상영관 추가시 영화의 상영관 수 증가, 상영관의 좌석 데이터 자동 추가하는 트리거
create or replace trigger trigger_add_theater
after insert on theaters for each row
begin
    -- 상영관 추가되면 영화 테이블의 상영관수 증가시킴
    update movies
    set theaters_count = theaters_count+1
    where id = :new.movie_id
    and :new.screening_datetime>= sysdate;

    -- 상영관 추가되면 좌석 테이블에 좌석 자동 추가
    sp_seats(:new.id, :new.remaining_seats_count);
end;
/

-- 좌석테이블의 is_soldout 업데이트시 상영관의 잔여 좌석수를 변경하는 트리거
create or replace trigger trigger_update_seats
after update on seats for each row
begin
    -- 예매하는 좌석일 경우
    if :new.is_soldout = 1 then
        update theaters
        set remaining_seats_count = remaining_seats_count - 1
        where id = :new.theater_id;
    -- 예매취소하는 좌석일 경우
    elsif :new.is_soldout = 0 then
        update theaters
        set remaining_seats_count = remaining_seats_count + 1
        where id = :new.theater_id;
    end if;
end;
/

-----------------------------------------------
-- 테스트용 데이터 삽입
insert into users values(users_seq.nextval, 'user01', '1234', '유저01', 0);
insert into users values(users_seq.nextval, 'manager01', '1234', '관리자01', 1);

insert into movies values(movies_seq.nextval, '라라랜드', '데이미언 셔젤', '황홀한 사랑, 순수한 희망, 격렬한 열정... 이 곳에서 모든 감정이 폭발한다!','2시간07분',  'movie1.png', 0);
insert into movies values(movies_seq.nextval, '파묘', '장재현', '수상한 묘를 이장한 풍수사와 장의사, 무속인들에게 벌어지는 기이한 사건을 담은 오컬트 미스터리 장르이다.','2시간13분', 'movie2.png', 0);
insert into movies values(movies_seq.nextval, '범죄도시4', '허명행', '나쁜 놈 잡는데 국경도 영역도 제한 없다! 업그레이드 소탕 작전! 거침없이 싹 쓸어버린다!','1시간49분','movie3.png', 0);
insert into movies values(movies_seq.nextval, '쿵푸팬더4', '마이크 미첼', '오랜만이지! 드림웍스 레전드 시리즈 마침내 컴백!', '1시간33분', 'movie4.png', 0);
insert into movies values(movies_seq.nextval, '듄: 파트2', '드니 빌뇌브', '한 소년이 스파이스를 보호하는 거대한 생명체를 가진 사막의 유목민들의 구원자가 된다.', '2시간45분', 'movie5.png', 0);
insert into movies values(movies_seq.nextval, '서울의 봄', '김성수', '1979년 12월 12일, 수도 서울 군사반란 발생. 그날, 대한민국의 운명이 바뀌었다.', '2시간21분', 'movie6.png', 0);
insert into movies values(movies_seq.nextval, '1987', '장준환', '한 사람이 죽고, 모든 것이 변화하기 시작했다. 모두가 뜨거웠던 1987년의 이야기.', '2시간09분', 'movie7.png', 0);
insert into movies values(movies_seq.nextval, '해리포터 아즈카반의 죄수', '알폰소 쿠아론', '해리를 위협하는 어둠의 세력, 그에 맞서는 해리의 활약! 놀라움으로 가득한 마법의 세계가 다시 펼쳐진다!', '2시간21분', 'movie8.png', 0);
commit;
to_char('2024-05-10 19:00:00', 'YYYY-MM-DD HH24:MI:SS');
insert into theaters values(theaters_seq.nextval, 1, TO_DATE('2024-05-13 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 60);
insert into theaters values(theaters_seq.nextval, 2, TO_DATE('2024-05-13 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 60);
insert into theaters values(theaters_seq.nextval, 1, TO_DATE('2024-05-13 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 60);
insert into theaters values(theaters_seq.nextval, 1, TO_DATE('2024-05-14 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 60);
insert into theaters values(theaters_seq.nextval, 1, TO_DATE('2024-05-14 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 60);
insert into theaters values(theaters_seq.nextval, 1, TO_DATE('2024-05-15 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 60);
insert into theaters values(theaters_seq.nextval, 3, TO_DATE('2024-05-14 10:10:00', 'YYYY-MM-DD HH24:MI:SS'), 60);
insert into theaters values(theaters_seq.nextval, 4, TO_DATE('2024-05-15 14:25:00', 'YYYY-MM-DD HH24:MI:SS'), 60);
insert into theaters values(theaters_seq.nextval, 1, '2024-04-15', '12:00', 5);
insert into theaters values(theaters_seq.nextval, 2, '2024-04-12', '14:00', 10);
insert into theaters values(theaters_seq.nextval, 3, '2024-04-14', '13:00', 20);
commit;
rollback;

select * from users;
select * from users where username='t123' and password='123';
select * from reservations;
select * from movies;
select * from movies where movie_title like '%'||?||'%';
select to_char(screening_datetime, 'YYYY-MM-DD HH24:MI:SS') from theaters;
select * from seats;
