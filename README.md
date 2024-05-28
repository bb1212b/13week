# 13week
is_leap_year() {
    year=$1
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

convert_month() {
    month_input=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    case $month_input in
        jan*|1) echo "Jan" ;;
        feb*|2) echo "Feb" ;;
        mar*|3) echo "Mar" ;;
        apr*|4) echo "Apr" ;;
        may*|5) echo "May" ;;
        jun*|6) echo "Jun" ;;
        jul*|7) echo "Jul" ;;
        aug*|8) echo "Aug" ;;
        sep*|9) echo "Sep" ;;
        oct*|10) echo "Oct" ;;
        nov*|11) echo "Nov" ;;
        dec*|12) echo "Dec" ;;
        *) echo "Invalid" ;;
    esac
}

if [ $# -ne 3 ]; then
    echo "입력값 오류"
    exit 1
fi

month=$(convert_month "$1")
day=$2
year=$3

if [ "$month" == "Invalid" ]; then
    echo "Invalid month: $1 $day $year는 유효하지 않습니다"
    exit 1
fi

if ! [[ "$day" =~ ^[0-9]+$ ]] || [ "$day" -le 0 ]; then
    echo "Invalid day: $1 $day $year는 유효하지 않습니다"
    exit 1
fi

if ! [[ "$year" =~ ^[0-9]+$ ]]; then
    echo "Invalid year: $1 $day $year는 유효하지 않습니다"
    exit 1
fi

case $month in
    "Jan"|"Mar"|"May"|"Jul"|"Aug"|"Oct"|"Dec") max_days=31 ;;
    "Apr"|"Jun"|"Sep"|"Nov") max_days=30 ;;
    "Feb")
        if is_leap_year "$year"; then
            max_days=29
        else
            max_days=28
        fi
        ;;
esac

if [ "$day" -gt "$max_days" ]; then
    echo "$month does not have $day days: $1 $day $year는 유효하지 않습니다"
    exit 1
fi

formatted_date="$(echo "$month $day $year" | tr '[:lower:]' '[:upper:]')"
echo "$formatted_date"

exit 0
