NB. Kernighan/Van Wyk benchmarks in J
NB. some add functions reworked for J idioms

load 'tables/dsv'

NB. sumloop
NB. loop to sum by incrementing in a loop
NB. done in non-J way
sumloop =: 3 : 0
sum =. 0
for_i. i. y do.
  sum =. sum + 1
end.
sum
)

NB. sumloop1 
NB. Proposed by Devon McCormack as a J version with looping by 
NB. the power operator, more analogous to an actual for loop
sumloopj1 =: <:@:>:^:#

NB. sumj
NB. sum consecutive integers as in J
sumj =: 13 : '+/ y$1'

NB. ackerman functon in J
NB. implementation from Jsoftware essays:
NB. https://code.jsoftware.com/wiki/Essays/Ackermann's_Function
ack=: c1`c1`c2`c3 @. (#.@,&*) M.
c1=: >:@]                        NB. if 0=x, 1+y
c2=: <:@[ ack 1:                 NB.s if 0=y, (x-1) ack 1
c3=: <:@[ ack [ ack <:@]         NB. else,   (x-1) ack x ack y-1

NB. array1 benchmark 
NB. fills 2 arrays with consequtive integers 
NB. one in ascending order and one in decending order
array1 =: 3 : 0
(i.y); i.(-y)
)

NB. as tacit definition
array1t =: 13 : '(i.y);i.(-y)'

NB. string1
NB. grows a string from 'abcedf' until it reaches
NB. the size given by the y input parameter
NB. then releases it and does it again 10 times
string1 =: 3 : 0
for_i. i. 10 do.
  s =. 'abcdef'
  while. (#s) <: y do.
   p =.'123',s,'456',s,'789'
   s =. p
   len =. #s
   p =. (-<.len%2){.s
   s =. p,(1+<.len%2){.s
  end.
end.
#s
)

NB. cat benchmark
NB. copies a file
NB. x - input file
NB. y - output file 
NB. the usual test is to download the King James Version of the bible
NB. in text (UTF-8) format and make a copy of it
NB. in the Benchmark function below this is placed in ~temp (J user dir)
cat =: 4 : 0
(freads x) fwrites y
)

NB. wc benchmark
NB. read a file output character count, word count and line count
wc =: 3 : 0
z =. freads y
lc =. +/ LF = z

NB. there are Carriage Return characters in the file string
NB. they will show up as words so I remove them from the string
wordc =. # ; cut each LF&cut CR&(-.~)z 

lc;wordc;#z
)

NB. tail benchmark
tail=: 4 : 0
 (;|.<;.2 freads x) fwrites y
)

NB. sum1 benchmark
NB. read from a file 100000 floating point numbers and sum them
sum1 =: 3 : 0
+/ ,makenum readdsv '~temp/randfloats.dsv'
)

NB. sum1j benchmark
NB. original C is to read from a file a list of random floating point
NB. values
NB. In this J version I create my own numbers in program
sum1j =: 3 : 0
nums =. ?y$0
+/nums
)

NB. benchmarks 
NB. the test bench for collected routines
KVWbmarks =: 3 : 0
smoutput 'sumloop: ',":timespacex 'sumloop 1000000'
smoutput 'sumloop1: ',":timespacex 'sumloop1 1000000'
smoutput 'sumj: ',":timespacex 'sumj 1000000'
smoutput 'ack: ',":timespacex '3 ack 8'
NB. assignment used in array call as that is part of the test
smoutput 'array1: ',": timespacex '''ip jp''=: array1 50000'
smoutput 'array1t: ',": timespacex '''ip jp''=: array1t 50000'
smoutput 'string1: ', ":timespacex 'string1 500000'
smoutput 'cat: ', ":timespacex '''~temp/KJVGut.txt'' cat ''~temp/KJV1.txt'''
smoutput 'wc: ', ":timespacex 'wc ''~temp/KJVGut.txt'''
smoutput 'tail: ',":timespacex '''~temp/KJVGut.txt'' tail ''~temp/KJV2.txt'''
smoutput 'sum1: ', ": timespacex 'sum1 100000'
smoutput 'sum1j: ', ":timespacex 'sum1j 100000'
)

NB. make a file with y random floating point numbers
NB. will use dsv addon for this
makeRFloat =: 3 : 0
rfloats =. (? y$500)+(? y $ 0)
rfloats writedsv '~temp/randfloats.dsv'
)
