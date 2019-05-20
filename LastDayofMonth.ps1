# This script checks if it's the last day of the current month. 
$Date = get-date # today's date
$lastDay = [DateTime]::DaysInMonth($Date.Year, $Date.Month) #Extract the last day of the current month. 

If ($Date.Day -eq $lastDay ) {

    "execute last of the month script" # do whatever you need to do if if it's the last day of the month. 

}Else {

        "It's not the last of the month yet"} # otherwise it's a normal day. 