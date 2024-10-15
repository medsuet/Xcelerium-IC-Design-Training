#include <stdio.h>
#include <stdlib.h>

// Define the Filter struct
typedef struct {
    float *taps;            // Filter coefficients
    float *delay_line;      // Delay line to store previous samples
    int sample;             // Current input sample
    int decimation_factor;  // Decimation factor
    int output_length;      // Number of filter taps (size of the delay line)
} Filter;

// Initialize the filter (constructor-like function)
void filter_init(Filter *filter, float *filter_taps, int num_taps, int dec_factor) {
    filter->taps = filter_taps;                         // Assign filter taps
    filter->decimation_factor = dec_factor;             // Set the decimation factor
    filter->output_length = num_taps;                   // Set the output length
    filter->delay_line = (float *)calloc(num_taps, sizeof(float));  // Initialize delay line with zeros
}

// Perform convolution and return the filtered output
float filter_convolve(Filter *filter, int new_sample) {
    // Shift the delay line to make space for the new sample
    for (int i = filter->output_length - 1; i > 0; i--) {
        filter->delay_line[i] = filter->delay_line[i - 1];
    }
    filter->delay_line[0] = new_sample;

    // Perform the convolution
    float sum = 0.0;
    for (int n = 0; n < filter->output_length; n++) {
        sum += filter->taps[n] * filter->delay_line[n];
    }
    return sum;
}

// Perform Decimation
float Decimation(Filter *filter,int input_sample) {
    
    float acc = 0.0;
    for (int n = 0; n < filter->decimation_factor; n++) {
         acc += filter_convolve(filter, input_sample);
    }
    return acc;
}




// Free the memory allocated for the delay line
void filter_free(Filter *filter) {
    free(filter->delay_line);
}

// Main function to demonstrate filter usage
int main() {
    // Example taps for the filter (5-tap averaging filter)
    float filter_taps[] = {0.2, 0.2, 0.2, 0.2, 0.2};
    int num_taps = sizeof(filter_taps) / sizeof(filter_taps[0]);
    int decimation_factor = 2;  // Example decimation factor

    // Create the Filter object
    Filter my_filter;
    filter_init(&my_filter, filter_taps, num_taps, decimation_factor);

    // Example input samples
    int input_samples[] = {1, 2, 3, 4, 5};
    int num_samples = sizeof(input_samples) / sizeof(input_samples[0]);

    printf("\nInputs: ");
    for (int i = 0; i < num_samples; i++) {
          printf(" %d ",input_samples[i]);
    }  
    printf("\nDecimation Factor %d\n",decimation_factor);
    printf("Filter Taps: ");
    for (int x = 0; x < num_taps; x++) {
          printf(" %f ",filter_taps[x]);
    }
    

    printf("\nConvolution\n");
    // Process input samples through the filter
    for (int i = 0; i < num_samples; i++) {
        float output = filter_convolve(&my_filter, input_samples[i]);
        printf("Filtered output for sample %d: %f\n", i, output);
    }

     printf("\nDecimation\n");
    // Decimate input samples through the filter
    for (int i = 0; i < num_samples; i++) {
        float out = Decimation(&my_filter, input_samples[i]);
        printf("Decimated output for sample %d: %f\n", i, out);
    }

    // Free resources
    filter_free(&my_filter);

    return 0;
}
