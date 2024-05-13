#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <utmp.h>

// TODO:
// man errno
// man strerror
// man 3 read

void
show_info (struct utmp *utbuf) {
  if (utbuf->ut_type != USER_PROCESS) {
    return;
  }

  time_t     t       = utbuf->ut_tv.tv_sec;
  struct tm *tm_info = localtime(&t);

  char buffer[20];
  strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M", tm_info);
  buffer[20] = '\0';

  printf("%-8.8s %-8.8s %s\n", utbuf->ut_user, utbuf->ut_line, buffer);
}

int
main (int argc, char const *argv[]) {
  struct utmp *utbuf_ptr;

  if (argc > 1 && strcmp(argv[1], "wtmp") == 0) {
    utmpname(_PATH_WTMP);
  } else {
    utmpname(_PATH_UTMP);
  }

  setutent();

#ifdef _GNU_SOURCE
  struct utmp utbuf;
  while (getutent_r(&utbuf, &utbuf_ptr) == 0) {
    show_info(&utbuf);
  }
#else
  while ((utbuf_ptr = getutent())) {
    show_info(utbuf_ptr);
  }
#endif

  endutent();

  return EXIT_SUCCESS;
}
