#include <stdlib.h>
#include <stdio.h>
int main(int argc, char** argv) {
  char cmd[1024];
  if (argc < 3) return 1;
  printf("Starting...\n");
  snprintf(cmd, sizeof(cmd), "%s %s %s", "/usr/local/libexec/tmrsync.sh", argv[1], argv[2]);
  int status = system(cmd);
  int ret = WEXITSTATUS(status);
  return ret;
}