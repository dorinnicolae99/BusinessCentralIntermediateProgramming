page 50100 "Calculate Lines"
{
    Caption = 'Calculate Lines';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Calculate Line";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Calculate Method"; Rec."Calculate Method")
                {
                }
                field(Number1; Rec.Number1)
                {
                }
                field(Number2; Rec.Number2)
                {
                }
                field(Result; Rec.Result)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                ApplicationArea = All;
                Caption = 'Calculate';
                Image = Calculate;

                trigger OnAction();
                var
                    ICalculate: Interface ICalculate;
                begin
                    ICalculate := Rec."Calculate Method";
                    ICalculate.Calculate(Rec);
                    Rec.Modify();
                end;
            }
        }
    }
}