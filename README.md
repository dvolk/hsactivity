hsactivity
==========

command line activity tracker in haskell


    dv@home:~/src/hsactivity$ ./dist/build/ha/ha start lollygaggin                                                     
    starting: lollygaggin
    dv@home:~/src/hsactivity$ ./dist/build/ha/ha stop lollygaggin
    stopping: lollygaggin
    dv@home:~/src/hsactivity$ ./dist/build/ha/ha start lollygaggin
    starting: lollygaggin
    dv@home:~/src/hsactivity$ ./dist/build/ha/ha show lollygaggin
    
    *** ongoing since 01/30/14 20:17:32 (4s ago)
    
    |---+-------------------+-------------------+------------|
    | n | start             | end               | diff (sec) |
    |---+-------------------+-------------------+------------|
    | 1 | 01/30/14 20:17:22 | 01/30/14 20:17:27 | 5          |
    |---+-------------------+-------------------+------------|
    dv@home:~/src/hsactivity$ ./dist/build/ha/ha stop lollygaggin
    stopping: lollygaggin
    dv@home:~/src/hsactivity$ ./dist/build/ha/ha show lollygaggin
    |---+-------------------+-------------------+------------|
    | n | start             | end               | diff (sec) |
    |---+-------------------+-------------------+------------|
    | 1 | 01/30/14 20:17:32 | 01/30/14 20:17:39 | 7          |
    | 2 | 01/30/14 20:17:22 | 01/30/14 20:17:27 | 5          |
    |---+-------------------+-------------------+------------|
