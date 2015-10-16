# Brainfuck.jl

It is a simple Brainfuck interpreter written in Julia. Why? Because we can!

While developing the interpreter, I'll be using the table below.

Brainfuck command | C equivalent
---------         | ------------
(Program Start)   |	char array[infinitely large size] = {0};
                  | char \*ptr=array;
>	                | ++ptr;
<	                | --ptr;
\+	|++\*ptr;
-	|--\*ptr;
.	|putchar(\*ptr);
,	|\*ptr=getchar();
[	|while (\*ptr) {
]	|}
