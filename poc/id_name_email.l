%{
#include <stdio.h>
%}

ID      [a-zA-Z_][a-zA-Z0-9_]*
NAME    [A-Z][a-zA-Z. ]+
EMAIL   [a-zA-Z0-9._]+@[a-zA-Z]+\.[a-zA-Z][a-zA-Z]+

%%

{EMAIL}         { printf("Valid Email Address: %s\n", yytext); }
{NAME}          { printf("Valid Person Name: %s\n", yytext); }
{ID}            { printf("Valid C Variable Name: %s\n", yytext); }
.               { ECHO; printf(" --> Invalid Input\n"); }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter input (Ctrl+C to end):\n");
    yylex();
    return 0;
}
