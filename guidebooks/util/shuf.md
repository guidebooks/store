---
validate: which shuf
---

# Shuf

The shuf command generates random permutations from input lines to standard output.

=== "MacOS"
    <!-- On MacOS shuf is part of coreutils, but is still invoked with 'shuf' since MacOS Catalina 10.15+ -->
    ```shell
    ---
    validate: which shuf
    ---
    brew install coreutils
    ```
    
=== "Linux"
    FIXME: this is debian/ubuntu-specific.
    
    ```shell
    ---
    validate: which shuf
    ---
    sudo apt -y install coreutils
    ```

=== "Windows"
    ```shell
    echo "Automatic installation of shuf not yet supported.
    exit 1
    ```