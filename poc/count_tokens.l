%{
#include <stdio.h>
#include <string.h>

/* Counters for different token types */
int keyword_count = 0;
int identifier_count = 0;
int operator_count = 0;
int separator_count = 0;

/* Array of C keywords */
char *keywords[] = {
 "auto", "break", "case", "char", "const", "continue", "default", "do",
 "double", "else", "enum", "extern", "float", "for", "goto", "if",
 "int", "long", "register", "return", "short", "signed", "sizeof", "static",
 "struct", "switch", "typedef", "union", "unsigned", "void", "volatile", "while"
};

int num_keywords = sizeof(keywords) / sizeof(keywords[0]);

/* Function to check if a string is a keyword */
int is_keyword(char *str) {
    for (int i = 0; i < num_keywords; i++) {
        if (strcmp(str, keywords[i]) == 0) {
            return 1;
        }   
    }
 return 0;
}

%}

%option noyywrap

/* Regular Expressions */
LETTER           [a-zA-Z]
DIGIT            [0-9]
IDENTIFIER       {LETTER}({LETTER}|{DIGIT}|_)*
OPERATOR         (\+\+|--|==|!=|<=|>=|&&|\|\||[-+*/%=&|!><^~])
SEPARATOR        [;,.(){}\[\]]
%%

{IDENTIFIER} {
 if (is_keyword(yytext)) {
    keyword_count++;
 } else {
    identifier_count++;
 }
}

{OPERATOR} {
 operator_count++;
 }

{SEPARATOR} {
    separator_count++;
}

[ \t\n]+    /* Ignore whitespace and newlines */

.           /* Ignore any other character */

%%

int main() {
    printf("Enter the input (press Ctrl+D or Ctrl+Z to end):\n");
    yylex(); /* Start lexical analysis */
    
    /* Print the counts */
    printf("\nKeywords: %d\n", keyword_count);
    printf("Identifiers: %d\n", identifier_count);
    printf("Operators: %d\n", operator_count);
    printf("Separators: %d\n", separator_count);
    printf("Total Tokens: %d\n", keyword_count + identifier_count + operator_count + separator_count);
    
    return 0;
}
