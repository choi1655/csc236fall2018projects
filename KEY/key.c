#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

int main() {
  system("/bin/stty raw");
  char ch;
  scanf("%c", &ch);
  while (ch != '.') {
    if (ch >= 'a' && ch <= 'z') {
      ch -= 32;
    }
    if ((ch >= 'A' && ch <= 'Z') || ch == ' ') {
      printf("%c", ch);
      scanf("%c", &ch);
    } else {
      scanf("%c", &ch);
      continue;
    }
  }
  system("/bin/stty cooked");
  printf("%c\n", ch);
  return EXIT_SUCCESS;
}
