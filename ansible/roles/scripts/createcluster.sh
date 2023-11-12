#!/bin/bash

#Get Credentials 
readCredentials() {


}




#Check Plugin 
if eval "rosa" > /dev/null ; then 
    echo "rosa found!"
    readCredentials
else
    exit 1
fi

#Rosa commands for creation

