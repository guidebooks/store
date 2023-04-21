{
    printf("\x1b[1;34m[Mem Utilization %4.1f%%] \x1b[0;34m%-30s \x1b[2m%13s %13s %s\x1b[0m\n",
           100*$1/$2,
           pod,
           $1,
           $2,
           $3);
    fflush();
}
