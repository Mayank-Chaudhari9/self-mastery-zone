base_cost=10
new_pay=10*1.5
total_payment=0
input_time_of_work=raw_input("enter the working hours\n")
try:
    time_of_work=int(input_time_of_work)
    if time_of_work<40:
        total_payment=time_of_work*10
    else:
        total_payment=(40*10) + (time_of_work-40)*new_pay
    print total_payment

except:
    print 'enter a valid number'
