# Salon Appointment Scheduler
## FreeCodeCamp Project
### Course: Relational Database

![Salon Project Image](https://github.com/Ulukai85/salon-appointment-scheduler/blob/main/salon.png)

This is one of the required projects to earn my certification for the FreeCodeCamp course "Relational Database".
For this project, I created an interactive Bash program that uses PostgreSQL to track the customers and appointments of a mockup salon.
More on this here: [FreeCodeCamp](https://www.freecodecamp.org/learn/relational-database/build-a-salon-appointment-scheduler-project/build-a-salon-appointment-scheduler)

I used a virtual gitpod environment to first build a SQL database with the tables 'services', 'customers' and 'appointments' after the specifications of FreeCodeCamp. For this I used PostgreSQL.
This is the resulting [salon.sql](https://github.com/Ulukai85/salon-appointment-scheduler/blob/main/salon.sql).

Then I scripted the bash file [salon.sh](https://github.com/Ulukai85/salon-appointment-scheduler/blob/main/salon.sh), again after exact prerequisites. Users can choose a service and enter their phone numbers.
Depending of their existence in the database they can choose an appointment time or have to give their names first, so that they can be entered into the database.
