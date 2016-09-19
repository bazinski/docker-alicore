#!/bin/sh

mount -t cvmfs alice.cern.ch /cvmfs/alice.cern.ch

mount -t cvmfs alice-ocdb.cern.ch /cvmfs/alice-ocdb.cern.ch

source /cvmfs/alice.cern.ch/etc/login.sh

if [ $# -gt 0 ]; then
  alienv enter $1 
else
  /bin/bash
fi


