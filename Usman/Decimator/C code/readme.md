 To run the the code write: 
           "make filter.c run"
c code contains the following functions:
1. init function:  
                This function initialize the filter i.e decimator factor,filter taps,delayline which save the input samples
2. filter_convolve:
                This function convolves the filter taps with input samples(that are stored in delay line).Delay line is an array                the shifts itself towards the right and place every new sample a index 0.
3. Decimation:
                This function  initialize the Decimator factor times filter  and then give inputs to each one by one , sum these                 results on each round. these sum results are our  output.
4. filter_free:
                This function free the every allocated memory  that we give it on its input.       
