pageextension 50120 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("Custom Category"; Rec."Custom Category")
            {
                ApplicationArea = All;
            }
        }
    }
}