%{
#include <stdio.h>
%}

DECIMAL     [0-9]+

%%

{DECIMAL}   {
                int n;
                sscanf(yytext, "%d", &n);
                printf("Decimal: %d -> Octal: %o\n", n, n);
            }

.|\n        { /* Ignore other characters */ }

%%

int main() {
    printf("Enter decimal numbers (Ctrl+C to end):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
