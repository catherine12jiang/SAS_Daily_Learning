/*  reading and filtering data with SQL */
title1 "international storms since 2000";
title2 "category 5 (wind>156)";
proc sql;
* you can use sas funcations directly on columns in proc sql;
select season, propcase(name) as name, startdate format=mmddyy10.,
	maxwindmph
	from pg1.storm_final
	where maxwindmph>156 and season>2000
	order by maxwindmph desc, name;
quit;


/*  creating and deleting tables in SQL */
proc sql;
create table work.myclass as
	select name, age, height 
	from pg1.class_birthdate
	where age>14
	order by height desc;
quit;


proc sql;
	drop table work.myclass;
quit;


/*  creating inner joins in proc SQL */
* same syntax as regualer SQL;


/*  using table aliases */
* from table1 as t1;


