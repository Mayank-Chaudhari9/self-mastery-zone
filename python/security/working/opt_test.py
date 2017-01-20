""" Taking arguements from command line using getopt module """
import getopt
import sys

name =""
age =""
course =""
student ="False"

def helpme():
    print "[*] Enter the command in following format"
    print
    print "opt_test.py -n name -a age -c course -s"
    print
    print
    print "[*] following options are equivalent"
    print
    print "-c   --course"
    print "-n   --name"
    print "-a   --age"
    print "-s   --student"



def main():
    global name
    global age
    global course
    global student

    try:
         opts,args=getopt.getopt(sys.argv[1:],"hn:a:c:s",["name","age","course","student"])
    except getopt.GetoptError as err:
        print sttr(err)
        helpme()


    for o,a in opts:
        if o in ("-h","--help"):
            helpme()
        elif o in ("-n","--name"):
            name =a
        elif o in ("-a","--age"):
            age=a
        elif o in ("-c","--course"):
            course=a
        elif o in ("-s","--student"):
            studen="False"
        else:
            print "Unhandelled option"

    print "Name : %s" %(name)
    print "Age : %s"%(age)
    print "Age : %s"%(course)
    print "Student : %s" %(student)

main()
