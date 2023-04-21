{
    # Wrangle nvidia-smi's timestamp into something POSIX worthy
    sub(/ /, "T", $1);
    gsub(/\//, "-", $1);

    printf "\x1b[1;36m[GPU Utilization %4.1f%%] \x1b[0;36m%s \x1b[0;2;36m%s \x1b[0;36m%sZ\n",
        $2,
        pod,
        $6,
        $1;

    printf "\x1b[1;36m[Mem Utilization %4.1f%%] \x1b[0;36mpod/%s \x1b[0;2;36m%s \x1b[0;36m%sZ\n",
        $3,
        pod,
        $4,
        $1;

    printf "\x1b[1;36m[Temp Current %4.1fC] \x1b[0;36mpod/%s \x1b[0;36m%sZ\n", $5, pod, $1;

    fflush();
}
