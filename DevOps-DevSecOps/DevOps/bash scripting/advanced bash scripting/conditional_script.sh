#!/bin/bash
echo "are you enjoying the course so far?"
echo -n "enter \"y\" for yes, \"n\" for no"
read response
if [ $response == "y" ]
then
    echo "we are glad to hear you are enjoying the course"
elif [ $response == "n" ]
then
    echo "we are sorry to hear that from you "
else 
    echo "your response must be either yes or no "
fi