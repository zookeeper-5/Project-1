#!/bin/bash



awk -F" " '{print $1, $2, $5, $6}' 0310_Dealer_schedule | grep 02
awk -F" " '{print $1, $2, $5, $6}' 0310_Dealer_schedule | grep 05
awk -F" " '{print $1, $2, $5, $6}' 0310_Dealer_schedule | grep 08
awk -F" " '{print $1, $2, $5, $6}' 0310_Dealer_schedule | grep 11

awk -F" " '{print $1, $2, $5, $6}' 0312_Dealer_schedule | grep 02
awk -F" " '{print $1, $2, $5, $6}' 0312_Dealer_schedule | grep 05
awk -F" " '{print $1, $2, $5, $6}' 0312_Dealer_schedule | grep 08
awk -F" " '{print $1, $2, $5, $6}' 0312_Dealer_schedule | grep 11

awk -F" " '{print $1, $2, $5, $6}' 0315_Dealer_schedule | grep 02
awk -F" " '{print $1, $2, $5, $6}' 0315_Dealer_schedule | grep 05
awk -F" " '{print $1, $2, $5, $6}' 0315_Dealer_schedule | grep 08
awk -F" " '{print $1, $2, $5, $6}' 0315_Dealer_schedule | grep 11
