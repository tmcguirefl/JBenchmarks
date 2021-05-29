⍝ Kernighan/Van Wyk benchmarks with implentation in Dyalog APL
⍝ You may have to cut an paste into a Dyalog edit session as I
⍝ have collected these in one file. But Dyalog seems to like to 
⍝ save functions within a 'workspace' at least on MacOS.
⍝ There may be a way to import enmass but I am not that familiar
⍝ with their environment. 
⍝ TODO: Add missing functions for the benchmark: cat, tail, and sum1

 ⍝ sumloop done in old style branching
 ∇Z←sumloop y {
 Z←0
 i←0
LOOP:→(i≥y)/LEND
 Z←Z+1
 i←i+1
 →LOOP
LEND:
∇

⍝ The more apl way to sum a set of ones
sumapl←{+/⍵⍴1}

⍝ sumloop implented with For: ForEnd: control statements
∇Z←sumloopfor y
 Z←0
 :For I :In ⍳y
     Z←Z+1
 :EndFor
 ∇
 
 ⍝ ackermann function taken from Rosetta code implementation
ack←{
     0=1⊃⍵:1+2⊃⍵
     0=2⊃⍵:∇(¯1+1⊃⍵)1
     ∇(¯1+1⊃⍵),∇(1⊃⍵),¯1+2⊃⍵
 }
 
⍝ Word count - done in a way to handle very large files which the 
⍝ J language implementation loads the whole file into memory
⍝ so not a fair comparison between the two languages (J and APL)
∇res←wc fn;c;w;l;fd;data;blk;nl;sp;lnsp;words
⍝ Taken from github weblog at:
⍝  https://ummaycoc.github.io/wc.apl/
 words←{≢(~⍵)⊆⍵}
 blk←256×1024
 nl←⎕UCS¨10 11 12 13
 sp←nl,⎕UCS¨9 32
 c←w←l←0
 fd←fn ⎕NTIE 0
 lnsp←0
 :Repeat
     data←⎕NREAD fd 80 blk
     :If 0=≢data
         :Leave
     :EndIf
     c←c+(≢data)
     l←l++/data∊nl
     data←data∊sp
     w←(w+words data)-(lnsp∧~1↑data)
     lnsp←~(¯1)↑data
 :EndRepeat
 ⎕NUNTIE fd
 res←l w c
 ∇
 
 array1←{(⍳⍵)(⌽⍳⍵)}
 
 Z←string1 y
 :For I :In ⍳10
     s←'abcdef'
     :While (≢s)≤y
         p←'123',s,'456',s,'789'
         s←p
         len←≢s
         p←(-⌊len÷2)↑s
         s←p,(1+⌊len÷2)↑s
     :EndWhile
 :EndFor
 Z←≢s
 
 ⍝ KVWbmarks - the benchmarks test harness
 ⍝ the PROFILE statements are included as I had first attempted to time
 ⍝ using the profiler. Then I found the time routine which was simpler
 ⍝ I left the PROFILE statements in comments in case there may be better timing
 ⍝ results to be gained in future
 KVWbmarks y;W
⍝  ⎕PROFILE'clear'
⍝  ⎕PROFILE'start' 'CPU'
⍝  W←sumloop 1000000
⍝  ⎕PROFILE'stop'
⍝  ans←⎕PROFILE'data'
⍝  ⍞←ans[1;1 4]
⍝  ⎕PROFILE'clear'
 ⍞←'sumloop: '
 W←sumloop time 1000000
 ⍞←⎕UCS 10
 
⍝  ⎕PROFILE'start' 'CPU'
⍝  W←sumapl 1000000
⍝  ⎕PROFILE'stop'
⍝  ans←⎕PROFILE'data'
⍝  ⍞←ans[1;1 4]
⍝  ⎕PROFILE'clear'
 ⍞←'sumapl: '
 W←sumapl time 1000000
 ⍞←⎕UCS 10
 
⍝  ⎕PROFILE'start' 'CPU'
⍝  W←sumloopfor 1000000
⍝  ⎕PROFILE'stop'
⍝  ans←⎕PROFILE'data'
⍝  ⍞←ans[1;1 4]
⍝  ⎕PROFILE'clear'
 ⍞←'sumloopfor: '
 W←sumloopfor time 1000000
 ⍞←⎕UCS 10
 
 ⍞←'ack: '
 W←ack time 3 8
 ⍞←⎕UCS 10

⍝  ⎕PROFILE'start' 'CPU'
⍝  W←array1 50000
⍝  ⎕PROFILE'stop'
⍝  ans←⎕PROFILE'data'
⍝  ⍞←ans[1;1 4]
⍝  ⎕PROFILE'clear'
 ⍞←'array1: '
 ip ij←array1 time 50000
 ⍞←⎕UCS 10

⍝  ⎕PROFILE'start' 'CPU'
⍝  W←string1 50000
⍝  ⎕PROFILE'stop'
⍝  ans←⎕PROFILE'data'
⍝  ⍞←ans[1;1 4]
⍝  ⎕PROFILE'clear'
 ⍞←'string1: '
 W←string1 time 1000000
 ⍞←⎕UCS 10
 ⍞←'wc: '
 W←wc time'/Users/tmcguire/J902-user/temp/KJVGut.txt'
 ⍞←⎕UCS 10
 
