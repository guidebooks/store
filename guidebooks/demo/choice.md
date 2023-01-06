# Offer a Choice

Choice is expressed using the
[pymdown](https://facelessuser.github.io/PyMdown/)
[Tabbed](https://facelessuser.github.io/pymdown-extensions/extensions/tabbed/)
syntax.

In this syntactic convention, indentation is important! The content of
a tab is indented by four spaces.

=== "Choice A"
    Description for choice A.

    ```shell
    echo "Executing task for ${choice}"
    ```
    
=== "Choice B"
    Description for choice B.

    Every choice must belong in its own file, thus to nest
    one choice within another, one must employ imports.
    :import{./choice2.md}

    ```shell
    echo "Executing task for ${choice}"
    ```
