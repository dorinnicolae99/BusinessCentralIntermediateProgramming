tableextension 50101 "Item Ext" extends Item
{
    fields
    {
        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                Rec."Search Description" := Rec.Description + '*';
            end;
        }
    }
}