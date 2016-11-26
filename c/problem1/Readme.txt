Readme
-------------
Problem1/
        |-test2.c
        |-Readme.txt
        |-test.o


1> Compilation:
  - compile the program with following command
          gcc -o test2 test2.c -lpthread

2> Running the problem
          ./test2

3> Methodology:
    Methods unsigned
        i)smoker()
            - function run by each smoker. The smoker makes cigrette on getting the contents and passes the control
              back to the agent through semaphore.


        ii)table()
            - function run by agent and. Agent puts the contents on the table and waits till the smoker take it.Agent generates the contents randomly.
