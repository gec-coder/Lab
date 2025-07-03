%{
#include <stdio.h>

int count = 0;
float total = 0;

%}

%%
[0-9]+(\.[0-9]+)? {
    total += atof(yytext);
    count++;
}

\n|" " { /* ignore whitespace */ }

%%
int main() {
    printf("Enter no.s: Use CTR + Z then enter to calculate avg.\n");
    yylex();

    if (count > 0) {
        printf("Average: %.2f\n", total/count);
    } else {
        printf("No numbers found.\n");
    }

    return 0;
}

int yywrap() {
 return 1;
}
