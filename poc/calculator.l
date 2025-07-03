%{
#include <stdio.h>
#include <stdlib.h>

int result = 0;       // Final result
int current_value = 0; // Value of the current number
int first = 1;         // Flag to check if it's the first number
%}

%option noyywrap

%%

[0-9]+      { current_value = atoi(yytext); return 'n'; } // 'n' for number
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"="         { return '='; }
[ \t\n]     { /* Ignore whitespace */ }
.           { printf("Invalid character: %c\n", *yytext); }

%%

int main() {
    printf("Enter expression (e.g., 5 + 3 * 2 =):\n");

    int op = 0;  // current operator
    while (1) {
        int token = yylex();
        if (token == 0) break;

        switch (token) {
            case 'n': // A number
                if (first) {
                    result = current_value;
                    first = 0;
                } else {
                    switch (op) {
                        case '+': result += current_value; break;
                        case '-': result -= current_value; break;
                        case '*': result *= current_value; break;
                        case '/':
                            if (current_value == 0) {
                                printf("Error: Division by zero\n");
                                return 1;
                            }
                            result /= current_value;
                            break;
                        default:
                            printf("Error: Operator missing before number\n");
                            return 1;
                    }
                }
                break;
            case '+':
            case '-':
            case '*':
            case '/':
                op = token; // store the current operator
                break;
            case '=':
                printf("Result: %d\n", result);
                // reset everything to allow a new calculation
                result = 0;
                current_value = 0;
                first = 1;
                break;
            default:
                printf("Error: Unknown input\n");
                return 1;
        }
    }
    return 0;
}
