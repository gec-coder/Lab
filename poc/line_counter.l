%{
#include <stdio.h>
int count = 0;
%}

%%

\n      { count++; }
.       ;  // Ignore everything else

%%

int yywrap() {
    return 1; // Tells Lex that input is complete
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    if (!fp) {
        printf("File opening failed");
        return 1;
    }

    yyin = fp;      // Use file as input
    yylex();        // Run the lexer

    printf("Total number of lines: %d\n", count);

    fclose(fp);
    return 0;
}
