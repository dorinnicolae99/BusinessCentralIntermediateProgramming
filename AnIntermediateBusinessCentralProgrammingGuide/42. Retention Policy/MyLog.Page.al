page 50100 "My Log"
{
    Caption = 'My Log';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "My Log";

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Message"; Rec.Message)
                {
                }
                field("Date"; Rec.Date)
                {
                }
                field(Status; Rec.Status)
                {
                }
            }

        }
    }
}


