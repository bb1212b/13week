convert_month()
{
    local month=$1
    case $month in
        jan|january|1) echo "Jan" ;;
        feb|february|2) echo "Feb" ;;
        mar|march|3) echo "Mar" ;;
        apr|april|4) echo "Apr" ;;
        may|5) echo "May" ;;
        jun|june|6) echo "Jun" ;;
        jul|july|7) echo "Jul" ;;
        aug|august|8) echo "Aug" ;;
        sep|september|9) echo "Sep" ;;
        oct|october|10) echo "Oct" ;;
        nov|november|11) echo "Nov" ;;
        dec|december|12) echo "Dec" ;;
        *) echo "Invalid month"; exit 1 ;;
    esac
}


is_leap_year() {
    local year=$1
    if (( year % 4 != 0 )); then
        return 1  
    elif (( year % 400 == 0 )); then
        return 0 
    elif (( year % 100 == 0 )); then
        return 1
    else
        return 0  
    fi
}


if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <month> <day> <year>"
    exit 1
fi


input_month=$1
day=$2
year=$3


month=$(convert_month "$input_month")


if ! [[ "$day" =~ ^[0-9]+$ ]] || [ "$day" -le 0 ]; then
    echo "Invalid day"
    exit 1
fi


is_leap_year "$year"
leap_year=$?


case $month in
    Jan|Mar|May|Jul|Aug|Oct|Dec) days_in_month=31 ;;
    Apr|Jun|Sep|Nov) days_in_month=30 ;;
    Feb)
        if [ "$leap_year" -eq 0 ]; then
            days_in_month=29
        else
            days_in_month=28
        fi
        ;;
    *) echo "Invalid month"; exit 1 ;;
esac


if [ "$day" -le "$days_in_month" ]; then
    echo "The date $month $day, $year is valid."
else
    echo "The date $month $day, $year is invalid."
fi