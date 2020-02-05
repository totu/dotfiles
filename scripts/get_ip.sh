#!/bin/bash
ifconfig |grep "10\.8" |awk -F' ' '{print $2}' |awk -F':' '{print $2}'

