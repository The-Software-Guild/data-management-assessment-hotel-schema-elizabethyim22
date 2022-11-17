-- 1. returns a list of reservations that end in July 2023, with guest name, room numbers, and dates
select 
guests.fName,
guests.lName,
roomRes.roomNum,
reservations.checkIn,
reservations.checkOut
from reservations
inner join guests on guests.guestId=reservations.guestId
inner join roomRes on roomRes.reservationId=reservations.reservationId
where checkOut between '2023-07-01' and '2023-07-31';
-- results:
-- 'Elizabeth','Yim','205','2023-06-28','2023-07-02'
-- 'Walter','Holaway','204','2023-07-13','2023-07-14'
-- 'Bettyann ','Seery','303','2023-07-28','2023-07-29'



-- 2. returns a list of all reservations for rooms with a jacuzzi, with guest name, room numbers, and dates
select
guests.fName,
guests.lName,
roomRes.roomNum,
reservations.checkIn,
reservations.checkOut
from roomRes 
inner join reservations on reservations.reservationId=roomRes.reservationId
inner join guests on guests.guestId=reservations.guestId
where roomRes.roomNum%2=1 and roomRes.roomNum between '200' and '308';
-- results:
-- 'Elizabeth','Yim','307','2023-03-17','2023-03-20'
-- 'Elizabeth','Yim','205','2023-06-28','2023-07-02'
-- 'Mack ','Simmer','301','2023-11-22','2023-11-25'
-- 'Bettyann ','Seery','203','2023-02-05','2023-02-10'
-- 'Bettyann ','Seery','303','2023-07-28','2023-07-29'
-- 'Bettyann ','Seery','305','2023-08-30','2023-09-01'
-- 'Duane ','Cullison','305','2023-02-22','2023-02-24'
-- 'Karie','Yang','201','2023-03-06','2023-03-07'
-- 'Karie','Yang','203','2023-09-13','2023-09-15'
-- 'Walter','Holaway','301','2023-04-09','2023-04-13'
-- 'Wilfred ','Vise','207','2023-04-23','2023-04-24'


-- 3. returns all the rooms reserved for a specific guest, with guest's name, rooms, checkIn date, and # people. 
-- Mack Simmer
select 
guests.fName,
guests.lName,
roomRes.roomNum,
reservations.checkIn,
reservations.adults+reservations.children as totalGuests
from reservations 
inner join guests on guests.guestId=reservations.guestId
inner join roomRes on roomRes.reservationId=reservations.reservationId
where guests.lName='Simmer';
-- results:
-- 'Mack ','Simmer','308','2023-02-02','1'
-- 'Mack ','Simmer','208','2023-09-16','2'
-- 'Mack ','Simmer','206','2023-11-22','2'
-- 'Mack ','Simmer','301','2023-11-22','4'



-- 4. returns a list of rooms, reservation ID, and per-room cost for each reservation. 
-- put in ascending order for clarity
select 
room.roomNum,
roomRes.reservationId
from room
left outer join roomRes on roomRes.roomNum=room.roomNum
order by roomNum asc;
-- results:
-- '204','16'
-- '205','15'
-- '206','12'
-- '206','23'
-- '207','10'
-- '208','13'
-- '208','20'
-- '301','9'
-- '301','24'
-- '302','6'
-- '302','25'
-- '303','18'
-- '304','8'
-- '304','14'
-- '305','3'
-- '305','19'
-- '306',NULL
-- '307','5'
-- '308','1'
-- '401','11'
-- '401','17'
-- '401','22'
-- '402',NULL



-- 5. returns all rooms with a capacity of three or more and that are reserved on any date in April 2023
select 
roomRes.roomNum
from roomRes
inner join reservations on reservations.reservationId=roomRes.reservationId
inner join room on room.roomNum=roomRes.roomNum
where 
(room.roomtypeId=1 or room.roomtypeId=3) 
and 
((reservations.checkIn between '2023-04-01' and '2023-04-30') or (reservations.checkOut between '2023-04-01' and '2023-04-30'));
-- results:
-- '304'
-- '301'



-- 6. returns a list of all guest names and the number of reservations per guest, sorted starting with the guest with the most reservations
select 
guests.fName,
guests.lName,
count(*) as numOccur
from reservations
inner join guests on guests.guestId=reservations.guestId
group by guests.guestId
order by numOccur desc;
-- results:
-- 'Mack ','Simmer','4'
-- 'Bettyann ','Seery','3'
-- 'Elizabeth','Yim','2'
-- 'Duane ','Cullison','2'
-- 'Karie','Yang','2'
-- 'Aurore','Lipton','2'
-- 'Walter','Holaway','2'
-- 'Wilfred ','Vise','2'
-- 'Maritza','Tilton','2'
-- 'Joleen','Tison','2'
-- 'Zachery','Luechtefeld','1'
-- 'Jeremiah','Pendergrass','1'



-- 6. and then by the guest's last name.
select 
guests.fName,
guests.lName,
count(*) as numOccur
from reservations
inner join guests on guests.guestId=reservations.guestId
group by guests.guestId
order by guests.lName asc;
-- results:
-- 'Duane ','Cullison','2'
-- 'Walter','Holaway','2'
-- 'Aurore','Lipton','2'
-- 'Zachery','Luechtefeld','1'
-- 'Jeremiah','Pendergrass','1'
-- 'Bettyann ','Seery','3'
-- 'Mack ','Simmer','4'
-- 'Maritza','Tilton','2'
-- 'Joleen','Tison','2'
-- 'Wilfred ','Vise','2'
-- 'Karie','Yang','2'
-- 'Elizabeth','Yim','2'



-- 7. displays the name, address, and phone number of a guest based on their phone number.
-- (291) 553-0508
select 
guests.fName,
guests.lName,
guests.address,
guests.phone
from guests
where guests.phone='(291) 553-0508';
-- results:
-- 'Mack ','Simmer','379 Old Shore Street','(291) 553-0508'
