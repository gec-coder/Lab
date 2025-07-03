%{
#include <stdio.h>

float sum = 0;
%}
%%
[0-9]+(\.[0-9]+)? {
    float num = atof(yytext);
    sum += num * num;
}

\n|" "  { /* ignore whitespace */ }
%%

int main() {
    printf("Enter no.s: Use CTR + Z then enter to calculate avg.\n");
    yylex();
    
    printf("Sum of squares: %.2f\n", sum);
    return 0;
}

int yywrap() {
    return 1;
}
