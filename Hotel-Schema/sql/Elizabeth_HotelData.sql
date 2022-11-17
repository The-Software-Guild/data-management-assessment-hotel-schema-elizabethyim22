set sql_safe_updates = 0;

delete from roomRes
where reservationId = 8;

delete from reservations 
where guestId = 8;


delete from guests 
where guestId = 8;

set sql_safe_updates = 1;