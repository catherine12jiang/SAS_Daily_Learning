/*  exporting data */
*   dbms= CSV  FOR CSV
		  TAB FOR TSV
		  XLSX FOR EXCEL FILES
	replace to overwirte if the file exisitng;	
/* 
proc export data=input-table outfile="output-file" dbms=identifier replace;	
run;
*/

%LET OUT_PATH = "s:/workshop/output/";

proc export data=sashelp.cars outfile="&OUT_PATH/cars.txt"
	dbms=tab replace;
run;


/*  exporting data to an excel workbook */
* another way to export data is using libname engine.
 creating table rather than exporting an exisitng table.
 you can write results directly to that target data. you need to have 
 write permission to the target destination;
libname xlout xlsx "&OUT_PATH/southpacific.xlsx";
data xlout.south_pacific;
...
run;
libname xlout clear;



/* exporting results to excel */
proc template;
	list styles;
run;

ods excel file="&OUT_PATH/wind.xlsx" style=sasdocprinter
	options(sheet_name='wind stats');
ods noproctitle;
proc means data=pg1.storm_final min mean median max maxdec=0;
	class basinname;
	var maxwindmph;
run;

ods excel options(sheet_name='wind distribution');
proc sgplot data=pg1.storm_final;
	histogram maxwindmph;
	density maxwindmph;
run;
ods excel close;







