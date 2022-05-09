pragma circom 2.0.0;

include "HelloWorld.circom";

// [assignment] Modify the circuit below to perform a multiplication of three signals

template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal input c;
   signal output d;  
  
   component multiplierA = Multiplier2();
   component multiplierB = Multiplier2();

   multiplierA.a <== a;
   multiplierA.b <== b;

   multiplierB.a <== multiplierA.c;
   multiplierB.b <== c;
   d <== multiplierB.c;

}