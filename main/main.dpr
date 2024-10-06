program main;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

var
  a, b, Eps, x, D, Dx : Real;
  i, Kmax, count : Integer;

Function f(x : Real) : Real;
begin
  // f := sqr(x-2) - 2
  // f := x*x*x - 6*x*x + 11*x - 6
  // f := 3*x - 4*ln(x) - 5
  // f := -x*x +5
  // f := sqr(x-2)
  f := x*x*x - 2*x + 2
end;

Function fp(x : Real) : Real;
begin
  D := Eps / 100;
  fp := (f(x + D) - f(x)) / D;
end;

Function f2p(x : Real) : Real;
begin
  D := Eps / 100;
  f2p := (f(x + D) + f(x - D) - 2*f(x)) / (D*D);
end;

begin
  count := 0;
  write('Input root interval, accuracy and max value of iterations: ');
  readln(a, b, Eps, Kmax);

  x := b;
  if f(x) * f2p(x) < 0 then
    x := a;
  if f(x) * f2p(x) < 0 then
  begin
    writeln('For a given equation, the convergence of Newton''s method is not guaranteed');
    readln;
  end;
  for i := 1 to Kmax do
  begin
    count := count + 1;
    if fp(x) = 0 then
    begin
      writeln('Unable to calculate the derivative at x = ', x, ' Try different interval');
      readln;
      exit;
    end;
    Dx := f(x) / fp(x);
    x := x - Dx;
    if abs(Dx) <= Eps then
    begin
      writeln('Root: ', x:0:10);
      writeln('Iterations: ', count);
      readln;
      exit;
    end;
  end;
  writeln('For the given number of iterations, no root was found with Eps precision');
  readln;
end.
