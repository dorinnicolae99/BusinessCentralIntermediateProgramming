enum 50100 "Calculate Method" implements ICalculate
{
    Extensible = true;

    value(0; Sum)
    {
        Caption = 'Sum';
        Implementation = ICalculate = "Calculate Sum";
    }
    value(1; Multiplication)
    {
        Caption = 'Multiplication';
        Implementation = ICalculate = "Calculate Multiplication";
    }
}