pageextension 50121 "Item Ledger Entries Ext" extends "Item Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Custom Category"; Rec."Custom Category")
            {
                ApplicationArea = All;
            }
        }
    }
}