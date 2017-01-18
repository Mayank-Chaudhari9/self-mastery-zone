base_cost=10
new_pay=10*1.5
total_payment=0
time_of_work=int(raw_input("enter the working hours\n"))
#print time_of_work
if time_of_work<40:
    total_payment=time_of_work*10
else:
    total_payment=(40*10) + (time_of_work-40)*new_pay

print total_payment
