%{
#include <stdio.h>
%}

%%

[0-9]+\.[0-9]+      { printf("Real number: %s\n", yytext); }
[0-9]+              { printf("Integer: %s\n", yytext); }
[a-zA-Z]+           { printf("Word: %s\n", yytext); }
[ \t\n]+            ;  // Ignore whitespace
.                   { printf("Unknown: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter input (Ctrl+C to end):\n");
    yylex();
    return 0;
}
