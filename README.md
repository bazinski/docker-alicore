Basic Docker container to be able to develop Alice software (for Run2) in a Linux environment (from a Mac, using
the Docker for Mac Beta).

The current setup assumes the container is launched using the ali-docker.sh script : 

```
ali-docker.sh AliRoot feature-reco-2016
```

The source code is kept on the Mac and bind mounted to the container, while the generated stuff (build, install, etc...) is kept in a Docker managed data container. 

The input part (i.e. reading the source from the bind mount) does not seem to be perfectly adequate as far as
performance goes. It seems `osxfs` is not yet up to the task... Hopefully that will improve in the future. The other option being to have also the input as part of a manager volume. But I'm not so sure I trust the system enough for the moment to have my development source code fully packed in a data container... 

The output part (writing the build files etc...)
on the other hand seems fine.

A number of other bind mounted volumes are used :

- .globus to be able to do `alien-token-init` from the container
- `$TOPDIR/alidist` for the recipes
- `$TOPDIR/AliRoot` (or `$TOPDIR/AliPhysics`) for the actual source code
- `$TOPDIR/repos/AliRoot` (or `$TOPDIR/AliPhysics`) for the actual original git clone (needed as the `$TOPDIR/AliRoot` is a
     git worktree)

where `$TOPDIR` is currently assumed to be
`$HOME/alicesw/run2/xxx-branch` (with xxx being AliRoot or AliPhysics)

