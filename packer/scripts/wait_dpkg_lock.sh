#!/bin/sh

echo Waiting for the apt process to exit ...

while pgrep apt
do
	sleep 5
done
