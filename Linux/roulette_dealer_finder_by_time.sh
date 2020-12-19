awk -F" " '{print $1, $2, $5, $6}' *Dealer_schedule | grep $1
