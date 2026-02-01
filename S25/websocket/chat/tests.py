from django.test import TestCase

# Create your tests here.
try:
    f = open("myfile.txt", "x")

    print("users:1")
except:
    f = open("myfile.txt","r+")
    users = int(f.read())
    f.close()
    users+=1
    f=open("myfile.txt","w")
    print("users:",str(users))

    print("hih")

