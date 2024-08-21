int add(int a, int b) {
  return a + b;
}

int mul(int a, int b) {
  return a * b;
}

int fib(int n) {
  if (n <= 1) {
    return n;
  }

  return fib(n-1) + fib(n-2);
}

void printing() {
  puts("Welcome!");
  printf("3 * 4 = %d\n", mul(3, 4));
  printf("Fibonacci number 10 is %d\n", fib(10));

  // %d - signed decimal integer
  // %f - decimal floating point
  // %s - string (e.g. "hello")
  // %% - literal % (e.g. %)
  // %p - pointer address (if given "hello" will print something like 0x7ffeefbff718)
  // \n - newline character, NOT automatically added to printf
}

void looping() {
  puts("Counting down from 1000 by 7s:");
  int c = 100;
  while (c > 0) {
    printf("%d\n", c);
    c = c - 7;
  }

  puts("Counting up from 0 by 7s:");
  for (int i = 0; i < 100; i += 7) {
    printf("%d\n", i);
  }
}

void conditionals() {
  puts("Fizzbuzzing up to 20:");
  for (int i = 1; i <= 20; i++) {
    if (i % 15 == 0) {
      puts("Fizzbuzz");
    } else if (i % 3 == 0) {
      puts("Fizz");
    } else if (i % 5 == 0) {
      puts("Buzz");
    } else {
      printf("%d\n", i);
    }
  }

  if (1 && !0 || 1) {
    puts("We made it!");
  }

  if (1 == 1 && 2 != 1 && 2 > 1 && 1 < 2 && 1 <= 1 && 2 >= 1) {
    puts("We made it again!");
  }
}

void basic_data_types() {
  int integer = 42;
  float decimal = 3.14;
  char character = 'a';
  size_t whatever = 100;
}

void arrays_and_strings() {
  int nums1[5];
  int nums2[] = {1, 2, 3, 4, 5};
  char greeting[6] = "hello";
}

struct Person {
  char name[50];
  int height;
};

void structs() {
  struct Person me = {"Charlie", 180};
  struct Person you = {.height = 180, .name = "Charlie"};
  printf("Person %s, height %dcm\n", me.name, me.height);
  printf("Person %s, height %dcm\n", you.name, you.height);
}
