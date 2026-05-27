---
dg-publish: true
---
x2025-12-07 00:12
course:[[CS50x]]

> ***This was a shit show***
# Hello World
![[image-9.webp]]
- Difference between print and printf
	can format with printf
- /n
	escape sequence that creates a new line
- Header Lines (e.g studio.h)
	  includes libraries
- how would you go abuot typing '',\,"" inside of the printf function 
	  you use a backlash before it  
	  e.g 
	  ![[Screenshot_20251206-132245.jpg]]
```  
{

    printf("hello, \"world\"\n");

}
```


> [!NOTE] Note
> For libraries manual pages (manpages) do exist and cs50 makes shit easier for you [here](manual.cs50.io)
# Ask user for name
  ![[image-10.webp]]
```
  # include <stdio.h>
# include <cs50.h>

int main(void)
{
    string answer = get_string("What's your name? ");
    printf ("hello, %s\n", answer);
}


```
-  here %s represents the place holder for the string and other inputs can be separrated by comma in printf func e.g
```
{
printf ("you are gay","sissy"); 
} 
```
- the above code is actually incorrect dumbass and here's why
	This C code is **not valid** because the `printf` function is called with the wrong number of arguments and an incorrect **format specifier**.

	The line in question is:
	
	```
	printf ("hello, \n", "sisy");
	```
	
	Here's a breakdown of the two main issues:
	
	### 1. 🛑 Incorrect Format String
	
	The **format string** is the first argument to `printf`, which is `"hello, \n"`.
	
	- A format string can contain ordinary characters (like `h`, `e`, `l`, `l`, `o`, `,`, and space) which are printed as is.
	    
	- It can also contain **format specifiers**, which start with a percent sign (`%`), such as `%d` (for an integer) or `%s` (for a string).
	    
	
	Your format string, `"hello, \n"`, contains **no format specifiers**. It only includes the text "hello, " and a newline character (`\n`). This means `printf` expects **only one argument**: the format string itself.
	
	### 2. 🔢 Too Many Arguments
	
	Since the format string contains no specifiers, `printf` is expecting only one argument. However, you provided **two arguments**:
	
	1. The format string: `"hello, \n"`
	    
	2. An extra string literal: `"sisy"`
	    
	
	When the number of arguments doesn't match the number of format specifiers, it leads to **Undefined Behavior** (a critical error). The compiler detects this mismatch and signals that the code is invalid.
	
	---
	
	### ✅ The Fix
	
	To make the code valid, you should either remove the extra argument or include a format specifier to accept the argument.
	
	#### Option A: Correctly Print "hello, " (Simplest Fix)
	
	Remove the unused string `"sisy"`:
	
	C
	
	```
	#include <stdio.h>
	
	int main(void)
	{
	    printf ("hello, \n"); // Only one argument (the format string)
	    return 0; // It's good practice to return 0 from main
	}
	```
	
	#### Option B: Print "hello, sisy"
	
	Include the `%s` format specifier to correctly print the string `"sisy"`:
	
	C
	
	```
	#include <stdio.h>
	
	int main(void)
	{
	    printf ("hello, %s\n", "sisy"); // Two arguments: format string with %s, and the string to insert
	    return 0;
	}
	```
	
	This version would correctly output:
	
	```
	hello, sisy
	```
# Conditionals
![[Screenshot_20251206-140755.jpg|466x209]] 
```
if (x < y)
{

}
else if (x > y)
{

}
else if (x == y)
{

}
```
- Why the double equal ==
	that's because equal is also used to assign a return valude e.g in
	```
 	string answer = get_string("What's your name? ");
 	```
- Why is this code not optimal
	- equal argument at the end isn't need if it isn't greater or less than it can only be equal
	```
		  
	if (x < y)
	{
	printf(" x is smaller to y")
	}
	else if (x > y)
	{
	printf(" x is greater to y")
	}
	else 
	{
	printf(" x is equal to y")
	}
	```
# Operators

![[image-14.webp|466x247]]
```
- = return value
- < less than
- <= less than or equal to
- > greater than
- >= greater than or equal to
- == equal to
- != not equal to
```
- = 
- < 
- <= 
- > 
- >= 
- == 
- != 

> [!NOTE] Note
> ! exclamation mark a.k.a bang is generally used to invert operators

# Variables
 - Assigning integers 
 ```
 int x = whatever
   ```
   - Asking user to define integer
   ```
   int x = get_int("What's x?");
   ```
   - incrementally increasing thingnies
   ```
   counter = counter + 1; (not math it copies value from right to left)
   or 
   counter += 1;
   or
   counter++ (you can only add 1)
   
   ```
-  works similarly 
   ```
   counter -= 1;
   or conter = counter - 1
   ```
# Data types 
# Format codes

# Agree.c (case sensitivity)
```
# include <stdio.h>
# include <cs50.h>

int main(void)
{

   char answer= get_char("Do you agree? ");
    if (answer== 'y')
    {
        printf("thankyou for agreeing to the terms and conditions\n");
    }
    else if (answer== 'n')
    {
        printf("fuck you\n");
    }
}
```
- you probably noticed an issue right the fact that users can't respond with yes and only y and n and capitalization isn't taken into account
	- this is one way of doing it
	![[image-15.webp]]
	- but this is still not efficient enough we can use the or thingy in the if fucntions argument (||)
	![[image-16.webp]]
	
> [!NOTE] Note
> You can use two ampersan (&) signs for and argument meaning both values must be true for the thingy to proceed 
> ![[image-17.webp]]
# Cat.c
## Using a while loop
```
#include <stdio.h>

int main(void)
{
    int counter = 3;
    while (counter > 0)
    {
        printf("meow\n");
        counter -= 1;
    }
}
```
- Using a while loop and an integer that decrements by 1 we can make the cat meow 3 times
- This can also be done counting up
```
	#include <stdio.h>
	
int main(void)
{

    int counter = 0;
    while (counter < 3)
    {
        printf("meow\n");
        counter += 1;
    }
}
```

- - Idk where to put this here but here's how to create a forever loop (uses cs50 library)
	![[image-18.webp]]
- What you can also do is to define something arbitrary that's always true
	```
	#include <stdio.h>
	int main(void)
	{
		while (50<51)
		{
			printf("meow\n");
		}
	}
	```
## Using a for loop
```
#include <stdio.h>

  

int main(void)

  

{

    for (int counter = 0; counter<3; counter += 1)

    {

        printf("meow\n");

    }

}
```

## Defining your own function
	like in scratch
```
void meow(void)
{
	printf("meow\n");
}
```
- Using it![[image-19.webp]]
```
	int main (void)
	{
		for(int counter = 0; counter<3; counter++)
		{
			meow();
		}
	}
```

- Putting it together
```
#include <stdio.h>

int main(void)
{
    for (int counter = 0; counter < 3; counter++)
    {
        meow();
    }
}

void meow(void)
{
    printf("meow\n");
}
```

> [!NOTE] Convention
> It is convention to put your own defined functions at the bottom the int "main" thingy is supposed to be top but it wont work since your calling a function thta is defined later in the order so to fix it, copy (don't remove the line from the bottom unc) and paste the functions first linen i.e void functionname(void) with semicolon to top of file above main while keeping the rest of it down

```
#include <stdio.h>

void meow(void);

int main(void)
{
    for (int counter = 0; counter < 3; counter++)
    {
        meow();
    }
}

void meow(void)
{
    printf("meow\n");
}
```

## Paramaterizing meow function 
- defining the int n instead of void in the "()"
```
#include <stdio.h>

void meow(void);

int main(void)
{
   meow(3)
}

void meow(int n)
{
   for (int counter = 0; counter < n; counter++)
   {
   printf("meow\n");
   }
}

```
### Prompting user for n
- using c50.h library for the thingy
```
#include <stdio.h>
#include <cs50.h>

void meow(int n);
  
  
int main(void)
{
    int n = get_int(" How many meows senpai ?" );
    meow(2);
}
  
void meow(int n)
{
    for (int counter=0; counter<n; counter++)
    {
        printf("meow\n");
    }
}
```
- Aren't the multiple n's prone to giving conflict
   
> [!NOTE] 
>variables only exist in the scrope of their { } , meanig both n's are separate entitites do not interact
> 	On the other hand variables can be used in { } within their scope e.g sis is defined outside do {}, if it were defined inside it the while(sis <1); and the meow(sis); would remain undefined
> 	
```
int main(void)

{
    int sis;
   do
   {
    sis=get_int("how many meows? ");
   }
   while (sis < 1);
    meow(sis);
}
```


 - or to stop confusion just use different thingies 
```
#include <stdio.h>
#include <cs50.h>

void meow(int n);
  
  
int main(void)
{
    int n = get_int(" How many meows senpai ?" );
    meow(2);
}
  
void meow(int n)
{
    for (int counter=0; counter<n; counter++)
    {
        printf("meow\n");
    }
}
```
### Do while loop
- Where would you use a do while loop over a for loop or a while loop
	where you're gonna be prompting the user again and again or doing said action again and again
```
#include <stdio.h>

#include <cs50.h>

void meow(int n);

int main(void)
{
    int sis;
   do
   {
    sis=get_int("how many meows? ");
   }
   while (sis < 1);
    meow(sis);
}

void meow(int n)
{
    for (int counter=0; counter<n; counter++)
    {
        printf("meow\n");
    }
}
```
## Defining Get-positive-int
```
#include <stdio.h>
#include <cs50.h>

  
void meow(int n);
int get_positive_int(void);
  

int main(void)
{
    int times = get_positive_int();
    meow(times);
}
 
  
// Functions
void meow(int n)
{
    for (int counter=0; counter<n; counter++)
    {
        printf("meow\n");
    }
}
  
int get_positive_int(void)
{
       int sis;
   do
   {
    sis=get_int("how many meows? ");
   }
   while (sis < 1);
   return sis;
}
```
- why is int get_positive_int(void) different from the rest,with regards to the int and void placement?
		![[IMG_20251207_221750.jpg|382x286]]

- [ ] 1:50:00 in vid elaborating on synctax for this shit  also define data types and the other thingy in the file [link](https://app.todoist.com/app/task/9805845873) #todoist %%[todoist_id:: 9805845873]%% 

## Nested Loops
- building a 3x3 block in a mario game or something
```
#include <stdio.h>
  
int main(void)
{
    for(int row = 0; row < 3; row++)
    {
        for (int brick =0; brick < 3; brick++)
        {
            printf("#");
        }
        printf("\n");
    } 

}
```

# Constants
make sure variable never changes 
![[image-20.webp]]


- [ ] kindly make a chunk map holy shit my brain is fired (make notes more streamlined aswell)
- [ ] Continue at 2:12

# Return values



# Integer Overflow
- solution
	using longs instead of integer
# Truncation
issues with division when using integers it doesn't reutrn whole values
	floats fix this
	you can also use casting vlues to fix this
		![[image-21.webp]]
# FLoating point imprescision
- doubles kinda fix


> [!NOTE] Relation between floating point imprecision and integer overflow
> 