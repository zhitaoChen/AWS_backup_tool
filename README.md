Check out [this](https://stevens.netmeister.org/615/#hw) website for more detail about that project.

## Implement way:

Since we need to use NetBSD to run the program and NetBSD do not
support bash, so I use sh(Bourne Shell) to implement. I tried
to think about using C++ to implement it, but it is so complex
since we need to use the variant of system tools to manipulate, so
I need to learn how to use this tools in C++, a little harder for me.

## About the software engineering:

1. Before coding, it took a long time to try to figure the logic of 
the program, what is the tool wants to do, which is I want the tool 
run what is user intended.

2. Always remember the words which you teach us: do one thing and do 
the thing well. So I split the program into several functions, and 
always concern about is the function really do one thing or not. 
If not, then try to split it into a smaller piece of code. 

3. When spilled it, surprisingly, some functions can reuse so many 
times which I never except.

4. While doing the white-box testing, I always try to make the edge 
cases and concer cases and try to increase the robustness

5. Try to use shared variables as less as I can, since I think
it may not good for the security

6. Try to make fewer steps to achieve the intention, e.g. if I want to
get the absolute path of the directory, I will use readlink(1) 
instead of e.g.: 
```
$ cd dir; pwd;
```
to make sure my code security

7. Use the system tools as much as I can instead of reinventing the 
wheel by my own.

8. Try to make less assumption as I can and let the user configure it,
which is the principle of The principle of least surprise

## Something about the detail:

1. Why check the input at first instead of using system 
tool to check the input?

It can save our time and do not make too much process to continue. 
And more important is that it will not make us has unexcept error. 
Actually, at the first time I think use system tools to check arguments
is good, but now I think it cannot exit gracefully since it 

2. How to define EC2_BACKUP_FLAGS_AWS and EC2_BACKUP_FLAGS_SSH?

In my view, I treat EC2_BACKUP_FLAGS_AWS as the custom flag of all
options, it will replace some options with the command
"aws ec2 run-instances --image-id ami-569ed93c \
--output text --query 'Instances[0].InstanceId" and also can
add some flag to the command, not simply append the string in
the variable to command.

So as to EC2_BACKUP_FLAGS_SSH, the user can define flag but
cannot define username and DNS address.

All in all, I try to make it follow the test case in manual and test
case in the mailing list you provide. But I think these two 
are different, e.g. 

We can invoke 
```
# aws $EC2_BACKUP_FLAGS_AWS
```
but we also need to 
```
$ export EC2_BACKUP_FLAGS_AWS="--instance-type t1.micro"
$ ec2-backup .
```
which is 
```
$ aws ec2 run-instance SOME_FLAGS $EC2_BACKUP_FLAGS_AWS
```
in my view.

So, I compare these two then use the second definition to 
work on my assignment.

3. You can see more detail and comments in my code.

## What I learn:

1. Most type of shell only return an integer which ranges between 
0 to 255

2. Different between getopts and getopt: first one is built-in
bash which can only parse short options, the other is not 
standard

3. In NetBSD, every device has its own name and function 

4. sh do not support arrays

5. sh do not support regular expression

6. About the shell scripting, I learn something about how to write 
the script and the script is more complex than I thought, it has 
a relative strict syntax than other programming languages e.g. C/C++,
especially the use of indent

7. About the software engineering, always remember principles you
taught, and try to implement it in coding. 
