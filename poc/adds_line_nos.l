%{
 #include <stdio.h>

 int line_number = 1;
%}

%%
\n      { printf("\n%3d: ", ++line_number); }
.       { putchar(yytext[0]); }
%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    printf("%3d: ", line_number);
    yylex();
    fclose(file);
    
    return 0;
}
int yywrap() {
 return 1;
}
