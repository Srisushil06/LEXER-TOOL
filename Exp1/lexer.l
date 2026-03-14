%{
#include <stdio.h>

FILE *fp;   // file pointer for output
%}

%%

int|float|if|else|return     { fprintf(fp, "<KEYWORD, %s>\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*       { fprintf(fp, "<IDENTIFIER, %s>\n", yytext); }
[0-9]+                       { fprintf(fp, "<NUMBER, %s>\n", yytext); }
"="                          { fprintf(fp, "<ASSIGN_OP, =>\n"); }
"+"|"-"|"*"|"/"              { fprintf(fp, "<ARITH_OP, %s>\n", yytext); }
">"|"<"|">="|"<="|"=="       { fprintf(fp, "<REL_OP, %s>\n", yytext); }
";"                          { fprintf(fp, "<SEMICOLON>\n"); }
"("                          { fprintf(fp, "<LPAREN>\n"); }
")"                          { fprintf(fp, "<RPAREN>\n"); }
[ \t\n]+                     ;   /* ignore whitespace */
.                            { fprintf(fp, "<INVALID, %s>\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main() {

    fp = fopen("lex_output.txt", "w");   // create output file

    if(fp == NULL){
        printf("Error opening file\n");
        return 1;
    }

    printf("Enter input:\n");
    yylex();

    fclose(fp);   // close file
    printf("Output saved in lex_output.txt\n");

    return 0;
}