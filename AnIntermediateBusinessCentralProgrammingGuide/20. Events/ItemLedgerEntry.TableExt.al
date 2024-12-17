tableextension 50121 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(50100; "Custom Category"; Code[20])
        {
            Caption = 'Custom Category';
            DataClassification = ToBeClassified;
        }
    }
}