%{
#include <stdio.h>

int count = 0;
char *target_word;

%}

%%
[a-zA-Z]+ {
    if (strcmp(yytext, target_word) == 0) {
        count++;
    }
}

.|\n { /* Ignore other characters */ }

%%

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Usage: %s <word> <filename>\n", argv[0]);
        return 1;
    }

    target_word = argv[1];
    yyin = fopen(argv[2], "r");

    if (!yyin) {
        perror("Error opening file");
        return 1;
    }

    yylex();
    fclose(yyin);

    printf("The word '%s' appears %d times.\n", target_word, count);
    return 0;
}

int yywrap() {
    return 1;
}
