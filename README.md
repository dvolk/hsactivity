hsactivity
==========

command line activity tracker in haskell


    $ ha start lollygaggin
    starting: lollygaggin
    
    $ ha stop lollygaggin
    stopping: lollygaggin
    
    $ ha start lollygaggin
    starting: lollygaggin
    
    $ ha show lollygaggin
    
    *** ongoing since 01/30/14 20:17:32 (4s ago)
    
    |---+-------------------+-------------------+------------|
    | n | start             | end               | diff (sec) |
    |---+-------------------+-------------------+------------|
    | 1 | 01/30/14 20:17:22 | 01/30/14 20:17:27 | 5          |
    |---+-------------------+-------------------+------------|
    
    $ ha stop lollygaggin
    stopping: lollygaggin
    
    $ ha show lollygaggin
    |---+-------------------+-------------------+------------|
    | n | start             | end               | diff (sec) |
    |---+-------------------+-------------------+------------|
    | 1 | 01/30/14 20:17:32 | 01/30/14 20:17:39 | 7          |
    | 2 | 01/30/14 20:17:22 | 01/30/14 20:17:27 | 5          |
    |---+-------------------+-------------------+------------|
