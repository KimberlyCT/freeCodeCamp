#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo "$($PSQL "TRUNCATE teams, games;")"
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
#exclude header
if [[ $WINNER != 'winner' ]]
then
  #check if existing row in teams table
  TEAM_ID_WINNER=$($PSQL"SELECT team_id FROM teams WHERE name='$WINNER';")
  #if not found
  if [[ -z $TEAM_ID_WINNER ]]
  then
    #insert team from winner column
    INSERT_TEAM_WINNER=$($PSQL"INSERT INTO teams(name) VALUES('$WINNER');")
    if [[ $INSERT_TEAM_WINNER = "INSERT 0 1" ]]
    then  echo "Inserted into teams, $WINNER"
    fi
  fi
  TEAM_ID_OPPONENT=$($PSQL"SELECT team_id FROM teams WHERE name='$OPPONENT';") 
  if [[ -z $TEAM_ID_OPPONENT ]]
  then
    #insert team from winner column
    INSERT_TEAM_OPPONENT=$($PSQL"INSERT INTO teams(name) VALUES('$OPPONENT');")
    if [[ $INSERT_TEAM_OPPONENT = "INSERT 0 1" ]]
    then  echo "Inserted into teams, $OPPONENT"
    fi
  fi
  # insert next
  TEAM_ID_WINNER=$($PSQL"SELECT team_id FROM teams WHERE name='$WINNER';")

#get winner & opponent_id
WINNER_ID=$($PSQL"SELECT team_id FROM teams WHERE name='$WINNER';")
OPPONENT_ID=$($PSQL"SELECT team_id FROM teams WHERE name='$OPPONENT';")


#check if existing row, get game_id by matching year,round,winner_goal,opponent_goal
GAME_ID=$($PSQL"SELECT game_id FROM games WHERE year = $YEAR AND round = '$ROUND' AND winner_id = $WINNER_ID AND opponent_id = $OPPONENT_ID;")
if [[ -z $GAME_ID ]]
  then
    #insert game
  INSERT_GAME=$($PSQL"INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS);")
      if [[ $INSERT_GAME = "INSERT 0 1" ]]
      then echo "Inserted into games, $YEAR $ROUND $WINNER_ID $OPPONENT_ID $WINNER_GOALS $OPPONENT_GOALS"
      fi
  GAME_ID=$($PSQL"SELECT game_id FROM games WHERE year = $YEAR AND round = '$ROUND' AND winner_id = $WINNER_ID AND opponent_id = $OPPONENT_ID;")
  fi
fi

done
