/*  using titles and footnotes */
* titlen "title-text"
  footnoten "footnote-text";
title1 "class report";
title2 "age";
footnote1 "schoold use only";

proc print data=pg1.class_birthdate;
run;



/*  using macro variables and functions in titles and footnotes */
%let age=13;

title1 "class report";
title2 "age=&age";
footnote1 "schoold use only";

proc print data=pg1.class_birthdate;
	where age=&age;
run;


/*  apply temporary labels to columns */
* labels are easy way to enhance report with more descriptive colums
headings;
* label col-name="label-text";

proc means data=sashelp.cars;
	where type='Sedan';
	var msrp mpg_highway;
	label MSRP="ABC"
		mpg_highway="QWE";
run;

*  most proc automatically display labels in results, but proc print is 
	exception, must add label option in proc print statement.
	to get rid of obs column displaed in result table, we can add noobs options;
proc print data=sashelp.cars label noobs;
	where type='Sedan';
	var msrp mpg_highway;
	label MSRP="ABC"
		mpg_highway="QWE";
run;


/*  applying permanent labels to columns */
* if we put label statement in data step. labels are assigned to columns as 
permanent attributes.
	you still need label option in proc print statement ;
data cars_update;
	set sashelp.cars;
	label MSRP="ABC"
		mpg_highway="QWE";
run;


/*  segmenting reports */
* use by statement in reporting proc to segment a report based on unique values
	of one or more columns. to do this, you must sort data first using same 
	by statement;
proc sort data=sashelp.cars out=cars_sort;
	by origin;
run;

proc freq data=cars_sort;
	by origin;
	* if you don't add tables statement, all columns will be used while generating freq table;
	tables Type; 
run;



/* creating freq reports and graphs */
ods graphics on; * to create visual representation, before proc freq step;
ods noproctitle; * proc title can be turned off;
title "frequency report";
* use order=freq to sequence report in desc frequencies.
	nlevels option is for number of varibale levels;
proc freq data=pg1.storm_final order=freq nlevels;
	* by using nocum option, cumulative freq and percent won't display in result.
	plots=freqplot option to create freq plot.
	scale= option by default is frequency counts;
	tables basinname startdate/nocum plots=freqplot(orient=horizontal scale=percent);
	* monname. to display month name;
	format startdate monname.;
	label startdate="storm month" basinname="basin";
run;


/*  creating two-way freq reports */
* if you want to suppress printed report, add noprint in proc freq;
proc freq data=pg1.storm_final noprint;
	* rows*columns
	if just want table include freq counts, after /, add norow nocol nopercent;
	tables basinname*startdate/norow nocol nopercent out=stormcounts;
	format startdate monname.;
	label startdate="storm month" basinname="basin";
run;


/* creating summary statistics reports */
* we can request different statistics.
	maxdec= option specify how many decimal places;
proc means data=pg1.storm_final mean median min max maxdec=0;
	var maxwindmph;
	* class statement allows to seperate statistics and calculate values within 
	groups. we could group by multiple columns;
	class basinname stormtype;
	* ways 0, statistics are calculated for entire table.
	ways 1, we have seperate two tables, one for basinname, one for stormtype.
	ways 2, we use combination of 2 columns;
	ways 0 1 2;
run;


/* Creating an output summary table */
* You can use the output statement in proc means to create a summary data set. 
	The out= option names the output table. In the output statement, you can 
	generate output statistics and name a column to store them in. ;
proc means data=pg1.storm_final noprint;
	var maxwindmph;
	class basinname stormtype;
	ways 1;
	output out=out_table mean=avg;
run;


