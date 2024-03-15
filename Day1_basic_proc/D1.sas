/* show 1st 10 rows */
proc print data=pg1.storm_summary(obs=10);
	var  Season Name Basin MaxWindMPH MinPressure StartDate EndDate;
run;

/* summary statistics */
proc means data=pg1.storm_summary;
	var MaxWindMPH MinPressure;
run;

/* Extreme Observations */
proc univariate data=pg1.storm_summary;
	var MaxWindMPH MinPressure;
run;



/* where statement */
proc print data=pg1.storm_summary;
	where MaxWindMPH>=156;
run;

proc print data=pg1.storm_summary;
	where basin="WP";
run;

proc print data=pg1.storm_summary;
	where basin in ("SI" "NI");
run;

proc print data=pg1.storm_summary;
	where startdate>="01JAN2010"d;
run;

proc print data=pg1.storm_summary;
	where  MaxWindMPH>=156 or MinPressure<920;
run;

proc print data=pg1.storm_summary;
	where  MaxWindMPH>=156 or 0<MinPressure<920;
run;


/* missing values */
proc print data=pg1.storm_summary;
	*when col data type is char;
	where Type=" ";
run;

proc print data=pg1.storm_summary;
	* when col data type is NUM;
	where MinPressure=.;
run;

/*  code can be used for either char or num */
where col-name IS NOT MISSING;
where col-name IS MISSING;

/*  work with data from DBMS */
where col-name is null;


/*  for both num and char range, endpoints are inclusive */
where col-name between value_1 and value_2;


/*  pattern matching */
/*  % is wildcard for any num of char */
/*  _ is wildcard for single char */
where col-name like "value";


/*  macro variable, temporary, must create it at beginning of program
before reference it  */
%let cartype=Wagon;

proc print data=sashelp.cars;
	where type= "&cartype";
	* where type="Wagon";
run;


%let ParkCode=ZION; 
%let SpeciesCat=Bird; 

proc freq data=pg1.np_species; 
	tables Abundance Conservation_Status; 
	where Species_ID like "&ParkCode%" and Category="&SpeciesCat"; 
run; 

proc print data=pg1.np_species; 
	var Species_ID Category Scientific_Name Common_Names; 
	where Species_ID like "&ParkCode%" and Category="&SpeciesCat"; 
run;








