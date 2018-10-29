//
//  main.c
//  Palindrome
//
//  Created by 伯驹 黄 on 2017/5/27.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

#include <stdio.h>

int IsPalindrome(const char *s, int n)
{
    if (s == NULL || n < 1)
    {
        return 0;
    }
    const char* first, *second;
    
    // m定位到字符串的中间位置
    int m = ((n >> 1) - 1) >= 0 ? (n >> 1) - 1 : 0;

    first = s + m;
    printf("first=%s\n", first);
    second = s + n - 1 - m;
    printf("second=%s\n\n", second);
    
    while (first >= s)
    {
        printf("first*=%c\n", *first);
        printf("second*=%c\n", *second);
        if (*first != *second)
        {
            return 0;
        }
        --first;
        printf("first☺=%s\n", first);
        ++second;
        printf("second☹=%s\n\n", second);
    }
    return 1;
}

void swap(char *a ,char *b)
{
    char temp = *a;
    *a = *b;
    *b = temp;
}

void Permutation(char* pStr, char* pBegin)
{
    
    if(*pBegin == '\0')
    printf("%s\n",pStr);
    else
    {
        for(char* pCh = pBegin; *pCh != '\0'; pCh++)
        {
            swap(pBegin, pCh);
            Permutation(pStr, pBegin+1);
            swap(pBegin, pCh);
        }
    }
}


int main(int argc, const char * argv[]) {
    // insert code here...
    int n = IsPalindrome("abcdcba", 7);
    printf("\n");
    printf("%d\n", n);

    char str[] = "abc";
    Permutation(str, str);
    return 0;
}
