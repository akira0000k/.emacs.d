#echo "*** ~/.zlogout ***"

echo -n "exit? (y/n) > "

if read line; then
   if [ "$line" = "n" ]; then
       exec zsh --login
   fi	
fi
