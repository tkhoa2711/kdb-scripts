/ util.q

/ check if the current kdb is HDB or RDB
is_hdb: { @[value;`.Q.pf;`rdb]~`date};

/ calculate the difference between current row and the next row
/ this is useful for determining the duration of each state transition
diff: { 1 rotate 1_deltas (1#x), x};
