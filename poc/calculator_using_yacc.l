(II) Implement a calculator using YACC
1. calc.l code
%{
#include "calc.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%%
[0-9]+        { yylval = atoi(yytext); return NUMBER; }
"+"           { return PLUS; }
"-"           { return MINUS; }
"*"           { return MULT; }
"/"           { return DIV; }
"("           { return LPAREN; }
")"           { return RPAREN; }
\n            { return EOL; }
[ \t]         { /* ignore whitespace */ }
.             { printf("Invalid character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}

2. calc.y code:
%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}
%token NUMBER PLUS MINUS MULT DIV LPAREN RPAREN EOL

%left PLUS MINUS
%left MULT DIV
%right UMINUS
%%
input:
      /* empty */
    | input line
    ;
line:
      EOL
    | expr EOL { printf("Result: %d\n", $1); }
    ;
expr:
      NUMBER                  { $$ = $1; }
    | expr PLUS expr          { $$ = $1 + $3; }
    | expr MINUS expr         { $$ = $1 - $3; }
    | expr MULT expr          { $$ = $1 * $3; }
    | expr DIV expr           { if ($3 == 0) yyerror("Division by zero"); else $$ = $1 / $3; }
    | LPAREN expr RPAREN      { $$ = $2; }
    | MINUS expr %prec UMINUS { $$ = -$2; }
    ;
%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
int main() {
    printf("Enter arithmetic expressions (e.g., 2 + 3 * 4). Press Ctrl+D to exit.\n");
    yyparse();
    return 0;
}
