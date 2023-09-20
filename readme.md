Heya!

I built this for cseccon's ctf and now it's open source!

#How to run this

##Cloud version (dont do this)
You need an aws account with a iam user called terraform. You will also need to add this user to the aws-cli thingy in linux.
Once this is done run these commands within the terraform folder.
```
terraform init
terraform apply -auto-approve
```
Then change out the ip's in the inventory.ini file and buildmealab.yml and run:
```
ansible-playbook -i inventory.ini buildmealab.yml
```


## Local machine (do this one)
Set up 4 windows machines, 2 as windows server 2022 and 2 as windows 10 machines.
change out the ip's in the inventory.ini file and in buildmealab.yml (ik it is messy sorry). Then run:
```
ansible-playbook -i inventory.ini buildmealab.yml
```
Take a 20min break and hope it installed without errors. If it did error, try running the script again. (I'm working on using ansible properly and rebuilding the lab so I wont be fixing issues with this version)

#Attacks
Read the ansible file :D
