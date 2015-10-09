/ util.q

/ check if the current kdb is HDB or RDB
is_hdb: { @[value;`.Q.pf;`rdb]~`date};

/ calculate the difference between current row and the next row
/ this is useful for determining the duration of each state transition
diff: { 1 rotate 1_deltas (1#x), x};

/ combine a date and a time strings into a datetime datum
/ "2015.08.31" + "09:00" -> 2015.08.31T09:00:00.0
to_datetime: {[d;t] :"p"$(trim[d] + "T"$trim[t]) };

/ state machine with state transition table
fsm: { ([ state: `s0`s1] event0: `s0`s1; event1: `s1`s0)[x;y] };

/ a function applies over a list of arguments and return a dictionary with the given id(s)
/ it's useful for retrieving the result for each of the id as we wish
apply: {[f;ids;args1;args2] ![ids; f'[ids;args1;args2]] };

/ perform a query/function to another remote kdb within a query
remote_q: {[host;f;arg1;arg2]
    h: hopen host;
    t: h (f;arg1;arg2);
    hclose h;
    :t
};

/ search for table whose name matches the regex
lookup: { {x where {x like y}[x;y]}[tables[];x] }
