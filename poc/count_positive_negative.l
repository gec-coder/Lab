%{
#include <stdio.h>

int pos_count = 0, neg_count = 0;
%}

%%

[+-]?[0-9]+ {
    int num = atoi(yytext);
    if (num > 0)
        pos_count++;
    else if (num < 0)
        neg_count++;
}

.|\n ; // Ignore everything else

%%

int main() {
    printf("Enter numbers (Ctrl+Z and enter to stop):\n");
    yylex();
    printf("Total Positive Numbers: %d\n", pos_count);
    printf("Total Negative Numbers: %d\n", neg_count);
    return 0;
}

int yywrap() {
    return 1;
}
