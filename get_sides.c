#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

long get_sides(double* side1, double* side2, double* side3) {
    char input[LINE_MAX];
    int result;

    // Get first side
    fflush(stdout);  // Ensure prompt is displayed
    if (fgets(input, LINE_MAX, stdin) == NULL) {
        return 0;
    }
    result = sscanf(input, "%lf", side1);
    if (result != 1) return 0;

    // Clear any leftover input
    int c;
    while ((c = getchar()) != '\n' && c != EOF);

    // Get second side
    fflush(stdout);  // Ensure prompt is displayed
    if (fgets(input, LINE_MAX, stdin) == NULL) {
        return 0;
    }
    result = sscanf(input, "%lf", side2);
    if (result != 1) return 0;

    // Clear any leftover input
    while ((c = getchar()) != '\n' && c != EOF);

    // Get third side
    fflush(stdout);  // Ensure prompt is displayed
    if (fgets(input, LINE_MAX, stdin) == NULL) {
        return 0;
    }
    result = sscanf(input, "%lf", side3);
    if (result != 1) return 0;

    // All inputs were valid
    return 1;
}
