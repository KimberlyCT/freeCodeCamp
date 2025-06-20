#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#declare functions

NUM_QUERY() {
  #query using atomic_number
  INPUT_MATCH_RESULT=$($PSQL "SELECT elements.atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM elements LEFT JOIN properties ON elements.atomic_number = properties.atomic_number LEFT JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number=$TO_SEARCH;")
  #if query match is empty
  if [[ -z $INPUT_MATCH_RESULT ]]
    then echo "I could not find that element in the database."
    else 
    echo -e "$INPUT_MATCH_RESULT" | while IFS="|" read NUM SYMBOL NAME MASS MELT BOIL TYPE 
    do echo "The element with atomic number $NUM is "$NAME" ("$SYMBOL"). It's a "$TYPE", with a mass of $MASS amu. "$NAME" has a melting point of $MELT celsius and a boiling point of "$BOIL" celsius."
    done
  fi
}

CHAR_QUERY(){
  INPUT_MATCH_RESULT=$($PSQL "SELECT * FROM elements LEFT JOIN properties ON elements.atomic_number = properties.atomic_number LEFT JOIN types ON properties.type_id = types.type_id WHERE (symbol='$TO_SEARCH') OR (name='$TO_SEARCH');")
  #if query match is empty
  if [[ -z $INPUT_MATCH_RESULT ]]
    then echo "I could not find that element in the database."
    else
      echo -e "$INPUT_MATCH_RESULT" | while IFS="|" read NUM SYMBOL NAME NUM2 MASS MELT BOIL TID TID2 TYPE 
      do echo "The element with atomic number $NUM is "$NAME" ("$SYMBOL"). It's a "$TYPE", with a mass of $MASS amu. "$NAME" has a melting point of $MELT celsius and a boiling point of "$BOIL" celsius."
      done
  fi
}

if [[ -z $1 ]]
  then echo "Please provide an element as an argument."
  else
    TO_SEARCH=$1
    # if input is a number
    if [[ $1 =~ ^[0-9]+$ ]]
      then NUM_QUERY
      else CHAR_QUERY
    fi
fi

