page 50145 "My Setup"
{
    Caption = 'My Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "My Setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'General';
                field("Is Installed"; Rec."Is Installed")
                {
                    ApplicationArea = All;
                }
                field("Is Reinstalled"; Rec."Is Reinstalled")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}