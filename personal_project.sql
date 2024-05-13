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
-- ���̺� ����
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
-- ������ ����
create sequence users_seq;
create sequence movies_seq;
create sequence theaters_seq;
create sequence reservations_seq;
create sequence seats_seq;

------------------------------------
-- ���ν���
-- �󿵰� �߰��� �ڵ����� �����Ǵ� �¼� ����Ʈ --
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

-- ��ȭ, �󿵰�, �¼� ���� �� ���Ž� ���� ������ �����ϰ� ���Ź�ȣ ����
create or replace procedure sp_create_reservation(v_user_id users.id%type, v_theater_id theaters.id%type, v_reservation_id out reservations.id%type)
is
begin
    -- ���� ���̺� ������ ����
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

-- ������ҽ� �ٽ� �ش� �¼� ������ �� �ֵ��� �¼� ���̺� ���� / �¼�_����, ���� ������ ����
create or replace procedure sp_delete_reservation(v_reservation_id reservations.id%type)
is
begin
    -- �¼� is_soldout 0���� ����
    update seats
    set is_soldout = 0
    where id in (select seat_id from seats_reservations where reservation_id = v_reservation_id);
    
    -- �¼�_���� ���̺� ������ ����
    delete from seats_reservations where reservation_id = v_reservation_id;    
    
    -- ���� ���̺� ������ ����
    delete from reservations where id = v_reservation_id;
end;
/

-- ���Ž� ������ �¼� �ٽ� ������ �� ������ �¼� ������ ���� / �¼�_���� ���̺� ������ ����
create or replace procedure sp_seat_reservation(v_reservation_id reservations.id%type, v_seat_id seats.id%type)
is
begin
    -- �¼� ���̺� ������ �¼� soldout ó��
    update seats
    set is_soldout = 1
    where id = v_seat_id;
    
    -- �¼�_���� ���̺� ������ ����
    insert into seats_reservations values(v_reservation_id, v_seat_id);
end;
/

-----------------------------------------------------
-- Ʈ���� ����

-- �󿵰� �߰��� ��ȭ�� �󿵰� �� ����, �󿵰��� �¼� ������ �ڵ� �߰��ϴ� Ʈ����
create or replace trigger trigger_add_theater
after insert on theaters for each row
begin
    -- �󿵰� �߰��Ǹ� ��ȭ ���̺��� �󿵰��� ������Ŵ
    update movies
    set theaters_count = theaters_count+1
    where id = :new.movie_id
    and :new.screening_datetime>= sysdate;

    -- �󿵰� �߰��Ǹ� �¼� ���̺� �¼� �ڵ� �߰�
    sp_seats(:new.id, :new.remaining_seats_count);
end;
/

-- �¼����̺��� is_soldout ������Ʈ�� �󿵰��� �ܿ� �¼����� �����ϴ� Ʈ����
create or replace trigger trigger_update_seats
after update on seats for each row
begin
    -- �����ϴ� �¼��� ���
    if :new.is_soldout = 1 then
        update theaters
        set remaining_seats_count = remaining_seats_count - 1
        where id = :new.theater_id;
    -- ��������ϴ� �¼��� ���
    elsif :new.is_soldout = 0 then
        update theaters
        set remaining_seats_count = remaining_seats_count + 1
        where id = :new.theater_id;
    end if;
end;
/

-----------------------------------------------
-- �׽�Ʈ�� ������ ����
insert into users values(users_seq.nextval, 'user01', '1234', '����01', 0);
insert into users values(users_seq.nextval, 'manager01', '1234', '������01', 1);

insert into movies values(movies_seq.nextval, '��󷣵�', '���̹̾� ����', 'ȲȦ�� ���, ������ ���, �ݷ��� ����... �� ������ ��� ������ �����Ѵ�!','2�ð�07��',  'movie1.png', 0);
insert into movies values(movies_seq.nextval, '�Ĺ�', '������', '������ ���� ������ ǳ����� ���ǻ�, �����ε鿡�� �������� ������ ����� ���� ����Ʈ �̽��͸� �帣�̴�.','2�ð�13��', 'movie2.png', 0);
insert into movies values(movies_seq.nextval, '���˵���4', '�����', '���� �� ��µ� ���浵 ������ ���� ����! ���׷��̵� ���� ����! ��ħ���� �� ���������!','1�ð�49��','movie3.png', 0);
insert into movies values(movies_seq.nextval, '��Ǫ�Ҵ�4', '����ũ ��ÿ', '����������! �帲���� ������ �ø��� ��ħ�� �Ĺ�!', '1�ð�33��', 'movie4.png', 0);
insert into movies values(movies_seq.nextval, '��: ��Ʈ2', '��� ������', '�� �ҳ��� �����̽��� ��ȣ�ϴ� �Ŵ��� ����ü�� ���� �縷�� ����ε��� �����ڰ� �ȴ�.', '2�ð�45��', 'movie5.png', 0);
insert into movies values(movies_seq.nextval, '������ ��', '�輺��', '1979�� 12�� 12��, ���� ���� ����ݶ� �߻�. �׳�, ���ѹα��� ����� �ٲ����.', '2�ð�21��', 'movie6.png', 0);
insert into movies values(movies_seq.nextval, '1987', '����ȯ', '�� ����� �װ�, ��� ���� ��ȭ�ϱ� �����ߴ�. ��ΰ� �߰ſ��� 1987���� �̾߱�.', '2�ð�09��', 'movie7.png', 0);
insert into movies values(movies_seq.nextval, '�ظ����� ����ī���� �˼�', '������ ��Ʒ�', '�ظ��� �����ϴ� ����� ����, �׿� �¼��� �ظ��� Ȱ��! �������� ������ ������ ���谡 �ٽ� ��������!', '2�ð�21��', 'movie8.png', 0);
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
