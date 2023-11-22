#!/bin/bash

# Credentials File Path
TOKEN=""  
path=$(pwd)
credentials_file="${path}/.credentials"  

# Get Credentials
readCredentials() {
    echo " -> reading credentials..."
    while IFS= read -r line
    do    
        TOKEN=$line
    done < $credentials_file
    echo $TOKEN  
}

# Login using TOKEN and create cluster 
createCluster() {
    echo -e "\n -> verifying credentials \n" 

    rosa login --token="$TOKEN" || { echo "ROSA login failed"; exit 1; }
    
    rosa verify quota || { echo "ROSA verify quota failed"; exit 1; }
    
    rosa create account-roles --mode auto || { echo "ROSA account creation failed"; exit 1; }

    echo -e "\n\n -> Enter your cluster name: " 
    read cname

    rosa create cluster --cluster-name $cname --sts --mode auto 

    # check exit status of the commands 
    if [ $? -eq 0 ]; then
        echo -e "\n -> ROSA creating cluster $cname \n" 
        rosa logs install -c $cname --watch
    else
        echo "ROSA cluster creation failed with exit status $?."
    fi
}

# Check if rosa command is available 
if command -v rosa > /dev/null; then
    echo "rosa found!"
    readCredentials  
    createCluster 
else
    echo "rosa not found. Exiting..."
    exit 1
fi
 
