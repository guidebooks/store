=== "Path to source [default: ./]"
    ```shell
    export _CUSTOM_WORKING_DIR_ORIG=${choice}
    ```

    ```shell
    export CUSTOM_WORKING_DIR=${choice}
    ```

    ```shell
    export CUSTOM_WORKING_DIR=$([[ "$CUSTOM_WORKING_DIR" =~ "https://github" ]] && echo $(mktemp -d) || echo "$CUSTOM_WORKING_DIR")
    ```
    
    ```shell
    if [[ "$_CUSTOM_WORKING_DIR_ORIG" =~ "https://github" ]]; then
        # Handle github urls
        
        cd "$CUSTOM_WORKING_DIR"

        if [[ -n "$CI" ]]; then
          # use plain http
          _WORKDIR_URL=$(echo "$_CUSTOM_WORKING_DIR_ORIG" | sed -E 's#(https://[^/]+)/.+$#\1/#')
        else
          # use ssh
          _WORKDIR_URL=$(echo "$_CUSTOM_WORKING_DIR_ORIG" | sed -E 's#https://([^/]+)/.+$#git@\1:#')
        fi

        _WORKDIR_ORG=$(echo "$_CUSTOM_WORKING_DIR_ORIG" | sed -E 's#https://[^/]+/([^/]+)/.+$#\1#')
        _WORKDIR_REPO=$(echo "$_CUSTOM_WORKING_DIR_ORIG" | sed -E 's#https://[^/]+/[^/]+/([^/]+)/.+$#\1#')
        _WORKDIR_BRANCH=$(echo "$_CUSTOM_WORKING_DIR_ORIG" | sed -E 's#https://[^/]+/[^/]+/[^/]+/tree/([^/]+)/.+$#\1#')
        _WORKDIR_SUBDIR=$(echo "$_CUSTOM_WORKING_DIR_ORIG" | sed -E 's#https://[^/]+/[^/]+/[^/]+/tree/[^/]+/(.+)$#\1#')

        _WORKDIR_FULL="${_WORKDIR_URL}${_WORKDIR_ORG}/${_WORKDIR_REPO}.git"
        echo "$(tput setaf 3)[Setup]$(tput sgr0) Cloning workdir $(tput setaf 6)${_WORKDIR_FULL}$(tput sgr0)"

        LOG=$(mktemp)
        set +e
        (git clone --quiet --no-checkout --filter=blob:none ${_WORKDIR_FULL} -b ${_WORKDIR_BRANCH} 2>> $LOG > /dev/null && \
             cd $_WORKDIR_REPO && \
             git sparse-checkout set --cone $_WORKDIR_SUBDIR 2>> $LOG > /dev/null && git checkout -q ${_WORKDIR_BRANCH} 2>> $LOG > /dev/null)
         if [ $? != 0 ]; then cat $LOG; exit $?; fi
         set -e
             
         echo "${CUSTOM_WORKING_DIR}/${_WORKDIR_REPO}/${_WORKDIR_SUBDIR}" > workdir.txt
    fi
    ```

    ```shell
    export CUSTOM_WORKING_DIR=$([[ -f "$CUSTOM_WORKING_DIR/workdir.txt" ]] && cat "$CUSTOM_WORKING_DIR/workdir.txt" || echo "$CUSTOM_WORKING_DIR")
    ```
