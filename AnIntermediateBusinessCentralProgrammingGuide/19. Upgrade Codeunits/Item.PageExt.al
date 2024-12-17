pageextension 50106 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("New Description"; Rec."New Description")
            {
                ApplicationArea = All;
            }
        }
    }
}