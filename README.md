# flutter_sqflite_plays

> A Flutter project for experimenting with sqflite package. 
This project makes use of related data, UI for processing data through CRUD, and version control of the database.
Communication with user through SnackBar will be implemented to notify user of changes they make to the DB.
Key Widgets used for enabling the CRUD will be mentioned along their use cases

# Objectives
* Store related data on local device using sqflite package
* Use proper flutter UI for displaying and processing data
* Communicate with User about changes made to the db
* Version control the sqflite database
* more TBD

# Assumptions
* The database tables will alter with time

# The projects involves the CRUD
> Create:
Creation of tables.
Insertion of records into tables. KEY WIDGETS [ FORM ]
Most records are added with automatic IDs.

> Read:
Reading records from tables. KEY WIDGETS [ FUTUREBUILDER, LISTVIEWBUILDER ]

> Update:
Updating existing records.

> Delete:
Deleting of records. Which should involve referenced records. KEY WIDGET [ DISMISSIBLE ]


# In this project we will cover the following as well:
* Altering tables which have existing records
* Storing Images
* Populating dropdown list with data from database
* Try two floatingActionButton for Person [ Pet, Hobby ]

