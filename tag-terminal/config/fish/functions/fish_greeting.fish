function fish_greeting
    seq -s- $COLUMNS|tr -d '[:digit:]'
    echo "* Don't forget to use new Julia commands!"
    echo "* Remember Visidata"
    seq -s- $COLUMNS|tr -d '[:digit:]'
    echo ""
end
