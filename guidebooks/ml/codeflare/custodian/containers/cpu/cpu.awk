$1=="usage_usec"     {to=$2}
$1=="user_usec"      {us=$2}
$1=="system_usec"    {sy=$2}
$1=="throttled_usec" {th=$2}
$1=="nr_periods"     {np=$2}
$1=="nr_throttled"   {nt=$2}
$1=="nanos"          {nanos=$2}
$1=="timestamp"      {now=$2}
$1=="------" {
    if (length(prev) > 0) {
        delta = (nanos - prev) / 1000;

        printf("\x1b[1;33m[CPU Utilization %4.1f%%] \x1b[0;33m%-30s \x1b[2m%s %s %s %s %s\x1b[0m\n",
               to/delta,
               pod,
               us,
               sy,
               to,
               th,
               timestamp);

        printf("\x1b[1;31m[CPU Throttling %4.1f%%] \x1b[0;31m%-30s \x1b[2m%s %s %s\x1b[0m\n",
               nt/np,
               pod,
               nt,
               np,
               timestamp);
        fflush();
    }

    prev = nanos;
}
