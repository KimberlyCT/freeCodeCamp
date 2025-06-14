#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n" 

LIST(){
  SERVICES=$($PSQL "SELECT * FROM services;")
  echo "$SERVICES" | while read ID BAR NAME
    do
      echo "$ID) $NAME"
    done
  }

MAIN_MENU() {
  
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  LIST
  read SERVICE_ID_SELECTED
  
  #verify if valid number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  #return to main menu
  then MAIN_MENU "I could not find that service. What would you like today?"
  return
  fi
  
  #verify service_id
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
  #if empty
  if [[ -z $SERVICE_NAME ]]
  #return to main menu
  then MAIN_MENU "I could not find that service. What would you like today?"
  return
  else
    echo -e "\n What's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_PHONE_RESULT=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")
    if [[ -z $CUSTOMER_PHONE_RESULT ]]
    then #get customer name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      #insert customer record
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi
  fi

  #set appointment
  echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  #get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '$CUSTOMER_NAME';")
  #insert appointment
  SET_APPOINTMENT=$($PSQL "INSERT INTO appointments( service_id, customer_id, time) VALUES($SERVICE_ID_SELECTED, $CUSTOMER_ID,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}

MAIN_MENU