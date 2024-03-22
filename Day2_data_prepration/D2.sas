/* using data step to create SAS date set */
* if output table you list in data statement exists, and you have wirte to access to 
to it, you will overwrite it and no undo;
data output-table;
	set input-table;
	* filter rows;
	where expression;
	* subset cols;
	drop/keep clo-name(s);
	* create new column;
	new-column=expression;
	* in data step, format permanently assign a format to column;
	format col-name;	
run;



/* using numeric functions to create columns */
data output-table;
	set input-table;
	new-column=function(arguments);
run;


/* using character functions to create columns */
* new-column=function(arguments);
data output-table;
	set input-table;
	new-column = upcase(col-name); * upper case;
	new-column = propcase(col-name); * init cap;
	new-column = cats(col-name1, col-name2); * concatenate, remove trailing
	and leading white space;
	new-column = substr(col-name, 2, 1); * extract substring, 2 means start from 
	2nd letter, 1 means length - how many chars to be returned ;
run;


/* conditional processing with if-then */
* missing vlaue is smaller than any num
 if you don't assign any value, e.g. when minpressure = 899, then pressuregroup
 is missing value;
data storm_new;
	set pg1.storm_summary;
	keep season minpressure pressuregroup;
	if minpressure=. then pressuregroup=.;
	if minpressure>920 then pressuregroup=0;
	if minpressure<0 then pressuregroup=1;
run;

/* SAS tests until 1st true condition, then skip the rest	 */
if expression then statement;
else if expression then statement;
else if expression then statement;
...
else statement;	


/* creating char columns with length statement */
*before conditional processing statements, explicitly define
char columns with length statement.
otherwise, the column cartype will be initialized as 5 chars of "basic";
data cars2;
	set sashelp.cars;
	length cartype $6;
	if MSRP<60000 then cartype="basic";
	else cartype='luxury';
run;
	

/* processing mutiple statements with if-then/do */
data indian atlantic pacific;
	set pg1.storm_summary;
	length ocean $8;
	basin=upcase(basin);
	oceancode=substr(basin,2,1);
	if oceancode='I' then do;
		ocean="Indian";
		output indian;
	end;
	else if oceancode='A' then do;
		ocean="Atlantic";
		output atlantic;
	end;
	else do;
		ocean="Pacific";
		output pacific;
	end;