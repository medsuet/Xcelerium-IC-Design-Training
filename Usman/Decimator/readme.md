                                              #Decimator
###calculations

Num of filters = decimation factor
   
output size    =   (num of samples + num of taps−1)/decimation factor 

output size    =     16 +16 -1/2  = 15 
###Bit Growth

output bits    =  2*input bits + log2(num of samples/deci factor)  //log due to bit growth

output bits    =  2*32 + 3 = 67 

###Fix Point

we are applying Fix Point in test bench.
sample width = 32bits -> integer part = 24bits  & Fractional part = 8bits.
step 1 -> convert numbers into integer
tep 2 -> perform calculation
step 3 -> convert back it into original form
      
3.2 x 0.1
step1 -> 32 x 1
step2 -> 32
step  -> 0.32
            
In test bench we are multiplying number by 2^(Fractional part) to convert it into integer.
Then giving it to the module.
dividing it by 2^(Fractional part) after receiving it when outout valid becomes high.
     
     
##Design
     
##Top level Diagram

        
             ![Top Level ](Design/design/DecimatorTop.drawio.png)
             
##DataPath

             ![DataPath](Design/design/DataPath.drawio.png)
            
##Filter

             ![Filter](Design/design/filter.drawio.png)
             
##Filter DataPath

             ![Filter DataPath](Design/design/Convolution_DataPath.drawio.png)
             
##Filter Controller

             ![Filter StateMachine](Design/design/FIR_StateMachine.drawio.png)
            
# TestBech Environment             
                                      
Generating Test Vectors using python code 
Corresponding answers also generating using a code found on this site that does that same work in parallel
                    
         "https://colab.research.google.com/github/kastnerkyle/kastnerkyle.github.io/blob/master/posts/polyphase-signal-processing/polyphase-signal-processing.ipynb#scrollTo=bDqr6yORAYhL"  

saving these test vectors  and results in file and reading this input file in testbench and  comparing it with saved output file generated using python code
     
     
     
     
     
      
      
      
      
      
      
      
      
