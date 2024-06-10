#!/bin/bash

echo -e "\n~~~~~ MY BARBERSHOP SHOP ~~~~~\n"
echo -e "Welcome to my Beard Sale Enterprise. At this time these are our Beards on Sale:\n" 
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

SALON_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  
  # fetch and print services
  SERVICES=$($PSQL "SELECT service_id, name FROM SERVICES ORDER BY service_id")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  echo -e "\nWhich style do you want? (1-6)"

  # get service id from user or ask again
  read SERVICE_ID_SELECTED

  if [[ ! $SERVICE_ID_SELECTED =~ ^[1-6]$ ]]
  then
    SALON_MENU "Please choose a valid service. (Input: 1-6 and Enter)"
  else
    HANDLE_APPOINTMENT
  fi
}
   
HANDLE_APPOINTMENT() {
  
  # save whitespace-stripped service name
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  SERVICE=$(echo $SERVICE_NAME | sed -E 's/^ *| *$//g')
  
  # get unique phone number from user
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # if there is no such number, ask for name and save new customer into db
  if [[ -z $CUSTOMER_ID ]]
  then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  fi
  
  # save whitespace-stripped name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id='$CUSTOMER_ID'")
  NAME=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')
  
  # get time from user
  echo -e "\nAt which time do you want an appointment, $NAME?"
  read SERVICE_TIME
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")

  # Print appointment overview 
  echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $NAME."
  
}

SALON_MENU