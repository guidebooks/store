$NF !~ /timestamp/ && $3 !="swpd" {
  printf("\x1b[1;33m[CPU Utilization %4.1f%%] \x1b[0;33mpod/%-30s \x1b[2m%14s %2s %2s %2s %2s %2s %sT%sZ\x1b[0m\n",
         $13+$14,
         pod,
         $4,
         $13,
         $14,
         $15,
         $16,
         $17,
         $(NF-1),
         $NF);
  fflush();
}
