#include <time.h>
#include <stdio.h>

int main() {
    time_t clk = time(NULL);
	printf("%s", ctime(&clk));
    return 0;
}
