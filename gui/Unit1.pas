unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    ButtonSolve: TButton;
    ButtonExit: TButton;
    EditA: TEdit;
    EditB: TEdit;
    EditEps: TEdit;
    LabelA: TLabel;
    LabelB: TLabel;
    LabelEps: TLabel;
    LabelC: TLabel;
    LabelIterations: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    procedure ButtonSolveClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a, b, Eps, D, Dx, x : Real;
  count, i, Kmax : Integer;

implementation

{$R *.dfm}

Function f(x : Real) : Real;
begin
  // f := sqr(x-2) - 2
  f := x*x*x - 6*x*x + 11*x - 6
  // f := 3*x - 4*ln(x) - 5
  // f := -x*x +5
  // f := sqr(x-2)
  // f := x*x*x - 2*x + 2
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

procedure TForm1.ButtonExitClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.ButtonSolveClick(Sender: TObject);
begin
  count := 0;
  a := StrToFloat(EditA.text);
  b := StrToFloat(EditB.text);
  Eps := StrToFloat(EditEps.text);
  Kmax := StrToInt(Edit1.text);

  x := b;
  if f(x) * f2p(x) < 0 then
    x := a;
  if f(x) * f2p(x) < 0 then
    ShowMessage('For a given equation, the convergence of Newton''s method is not guaranteed');
  for i := 1 to Kmax do
  begin
    count := count + 1;
    if fp(x) = 0 then
    begin
      ShowMessage('Unable to calculate the derivative. Try different interval');
      exit;
    end;
    Dx := f(x) / fp(x);
    x := x - Dx;
    if abs(Dx) <= Eps then
    begin
      LabelC.caption := 'Root: ' + FloatToStr(x);
      LabelIterations.caption := 'Iterations: ' + FloatToStr(count);
      exit;
    end;
  end;
  ShowMessage('For the given number of iterations, no root was found with Eps precision');
end;

end.
