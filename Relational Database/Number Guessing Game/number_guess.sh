#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MAIN(){
echo "Enter your username:"
read USERNAME
USERNAME_CHECKER

SECRET_NUMBER=$(( RANDOM%1001 ))
echo "Guess the secret number between 1 and 1000:"
read GUESS_INPUT
GUESS_COUNTER

echo You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!
INSERT_RECORD
}

USERNAME_CHECKER() {
UN_LEN=${#USERNAME}
if [[ ! UN_LEN -le 22 ]]
then MAIN "Up to 22 char only."
return
else 
  #query user
  USER_MATCH_RESULT=$($PSQL "SELECT username FROM users WHERE username='$USERNAME';")
  #if query does not exists
  if [[ -z $USER_MATCH_RESULT ]]
  then echo "Welcome, $USERNAME! It looks like this is your first time here."
  ADD_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME');")
  #if user exists
  else 
  #query total number of games user played
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM users LEFT JOIN game_record ON users.user_id=game_record.user_id WHERE username='$USERNAME';")
  #query least number of guesses on a game
  BEST_GAME=$($PSQL "SELECT MIN(no_of_guesses) FROM users LEFT JOIN game_record ON users.user_id=game_record.user_id WHERE username='$USERNAME';")

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
fi
}

GUESS_COUNTER(){
NUMBER_OF_GUESSES=1
while [[ $GUESS_INPUT != $SECRET_NUMBER ]] 
do
  if [[ $GUESS_INPUT =~ ^[0-9]+$ ]] && (( $GUESS_INPUT > $SECRET_NUMBER ))
  then  
  echo "It's lower than that, guess again:"
  else
    if [[ $GUESS_INPUT =~ ^[0-9]+$ ]] && (( $GUESS_INPUT < $SECRET_NUMBER ))
    then
    echo "It's higher than that, guess again:"
    else
    echo "That is not an integer, guess again:"
    fi
  fi
read GUESS_INPUT 
(( NUMBER_OF_GUESSES++ ))
done
}

INSERT_RECORD(){
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME';")
INSERT_RESULT=$($PSQL "INSERT INTO game_record(user_id,no_of_guesses) VALUES ($USER_ID,$NUMBER_OF_GUESSES);")
}

MAIN