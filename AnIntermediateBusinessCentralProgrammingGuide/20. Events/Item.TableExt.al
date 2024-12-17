tableextension 50120 "Item Ext" extends Item
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