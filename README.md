# JBenchmarks
J language benchmarks: 
## Kernighan/Van Wyk
A set of functions that implement the Kernighan/Van Wyk benchmarks (originally made to run in C language) with a test harness function runs them using the timing and memory functions built into J.

Requires a copy of the King James Version of the Bible (or other large text) which can be found at Project Gutenburg:\
https://www.gutenberg.org/ebooks/10

__KWVbmarks.ijs__ is the J language script file that implements the benchmark\
__KWVbmarks__ function is the test harness for the collected rouines\
__usage:__ KWVbmarks ''

__NOTE:__ KWVBmarks expects the KVJ bible file to be in the ~temp directory (j903/temp). This directory is in the j903 user directory in your home directory. 
The sum1 routine (within KWVBmarks) expects a file of floats to be placed in the same directory. There is a generation routine called makeRFloat that will generate a file in the appropriate directory and name the file randfloats.dsv. Just call makeRFloat with an empty string: makeRFloat''

## Advanced Benchmarks
These were loosely taken from a scheme language set of benchmarks and use J language implemetation that is similar but not a direct transcription of the scheme routines.

__ADVbenchmarks.ijs__ is the J language script file that contains these benchmarks\
__ADVbmarks__ function is the test harness\
__usage:__ ADVbmarks ''

## Kernighan/Van Wyk benchmarks in APL
Similar benchmarks done in APL to allow for some cross language performance comparison. There are enough differences in the implementations 
and a lack of APL idiom knowledge by the author such that a true performance comparison can not be made. However it is a nice start 
to see how some simple things are accomplised in both languages and in a general sense both perform quite fast enough for personal use.

## Further J Benchmarks
Devon McCormick has a set of Benchmarks he wrote for J contained in a J script at the J Software website. You can find them here:\
https://code.jsoftware.com/mediawiki/images/e/e2/Bmks.ijs

## Benchmarks discussed:
Discussion of J Benchmarks during the NYC J Users Group:\
https://code.jsoftware.com/wiki/NYCJUG/2021-06-08

Benchmark discussion thread about the implementation done in this Github repository:\
http://www.jsoftware.com/pipermail/programming/2021-May/058182.html
