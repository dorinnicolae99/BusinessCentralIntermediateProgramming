codeunit 50101 "Calculate Multiplication" implements ICalculate
{
    procedure Calculate(var CalculateLine: Record "Calculate Line")
    begin
        CalculateLine.Result := CalculateLine.Number1 * CalculateLine.Number2;
    end;
}