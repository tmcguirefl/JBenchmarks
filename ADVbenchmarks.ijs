NB. Selected Benchmarks from Scheme benchmark site

load 'math/calculus'
load 'math/fftw'

NB. Takeuchi function triple recursive
tak =: 3 : 0
X =. 0{y
Y =. 1{y
Z =. 2{y
if. Y >: X do.
  Z
  return.
end.
tak (tak (X-1),Y,Z),(tak (Y-1),Z,X),(tak (Z-1),X,Y)
)

NB. fibN - returns Nth fibonacci number
NB. taken from rosetta code
fibN=: (-&2 +&$: -&1)^:(1&<) M."0

NB. rsum - recursive sum of integers
NB. usage:
NB. x is the number to sum from 0 (inclusive)
NB. y is the sum (which will start at 0)
rsum =: 4 : 0
if. x < 0 do.
  y
  return.
end.
(x-1) rsum x+y
)

NB. mbrot
NB. generation of the mandelbrot set
mcf=: (<: 2:)@|@(] ((*:@] + [)^:((<: 2:)@|@])^:1000) 0:) NB. 1000 iterations test
domain=: |.@|:@({.@[ + ] *~ j./&i.&>/@+.@(1j1 + ] %~ -~/@[))&>/

NB.mcf "0 @ domain (_2j_1 1j1) ; 0.1 NB. Complex interval and resolution

NB. Fast Fourier transform fftw
NB. this is a J wrapper over a C implementation of fft
NB. found in library math/fftw

NB. 6 dimensional data for fftw and ifftw benchmarks
NB. taken from the fftw lab
fftA=: j./ ?. 1 + i. 2 3 4 5 6 7 8

NB. usage: fftB=: fftw fftA
NB. usage: ifftw fftB
NB. timing displayed under labels fftw and ifftw respectively

NB. definition of fourier transform in J
basis=: %: %~ 0j2p1&% ^@* */~@i.
   ft=: +/ .* basis@#

NB. data to be used for ft benchmark
NB. this is compared to the fftw and output with label fftws (s suffix indicates small dataset)
data=: 1p_0.1 * 2 o. 0.2p1 * i.10


NB. ADVbmarks 
NB. the test bench for collected routines from selected scheme benchmarks 
NB. implemented in the J language
ADVbmarks =: 3 : 0
smoutput 'tak: ',":timespacex 'tak 18 12 6'
smoutput 'fibN: ',":timespacex 'fibN 40'
smoutput 'rsum: ',":timespacex '10000 rsum 0'
smoutput 'mbrot: ',":timespacex 'mcf "0 @ domain (_2j_1 1j1) ; 0.04'
smoutput 'deriv: ',":timespacex '5 5 30&p. deriv_jcalculus_ 1'
smoutput 'fftw: ',":timespacex 'fftB=: fftw fftA'
smoutput 'ifftw: ',":timespacex 'ifftw fftB'
smoutput 'ft: ',":timespacex '<.&.(1e12&*)@(1e_14&+) ft data'
smoutput 'fftws: ',": timespacex '<.&.(1e12&*)@(1e_14&+) fftw data'
)
