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
