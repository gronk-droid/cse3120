# Sample Midterm II Test Programming Problems

1. Write BY HAND on paper (typing not accepted!) a .386 flat model procedure named MulThree, using PROC (without USES or parameters), that receives three unsigned “short int” (16bit) parameters, valA, valB, valC, according to the C calling convention and returns in EAX the result as (int on 32 bit) of (unsigned(valA)*unsigned(valB)-int(valC))



During computations, the product valA*valB must be computed and temporarily stored in a local variable called “sum” on the stack!

Make sure to preserve previous values of all registers other than the one used for returning the result!
