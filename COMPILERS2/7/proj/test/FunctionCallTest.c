int main(double a)
{
  double d;

  d = 0;

  foo(d);

}

int foo(double d)
{
  printf("Printing %d\n", d);
  return d;
}