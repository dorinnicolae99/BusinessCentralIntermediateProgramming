page 50100 "JQ Log"
{
    Caption = 'JQ Log';
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "JQ Log";

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Date and Time"; Rec."Date and Time")
                {
                }
            }
        }
    }
}