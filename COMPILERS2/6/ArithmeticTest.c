main(int a)
{
  int b;

  b = 5;
  printf("b=1\n a: %d\nb: %d\n",a,b);
  a = b;
  printf("a=nb\na: %d\nb: %d\n",a,b);
  a = a + b;
  printf("a+b\na: %d\nb: %d\n",a,b);
  a = a - b;
  printf("a-b\na: %d\nb: %d\n",a,b);
  a = a * b;
  printf("a*b\na: %d\nb: %d\n",a,b);
  a = a / 2;
  printf("a\\2\na: %d\nb: %d\n",a,b);
  a = a | b;
  printf("a|b\na: %d\nb: %d\n",a,b);
  a = a & b;
  printf("a&b\na: %d\nb: %d\n",a,b);
  a = a ^ b;
  printf("a^b\na: %d\nb: %d\n",a,b);
  a = a << b;
  printf("a<<b\na: %d\nb: %d\n",a,b);
  a = a >> b;
  printf("a>>b\na: %d\nb: %d\n",a,b);
}