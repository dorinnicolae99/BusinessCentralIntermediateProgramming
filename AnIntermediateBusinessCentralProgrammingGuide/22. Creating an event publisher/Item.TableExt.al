tableextension 50120 "Item Ext" extends Item
{
    fields
    {
        field(50100; "Custom Category"; Code[20])
        {
            Caption = 'Custom Category';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateCustomCategory(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                TestNoOpenEntriesExist(FieldName("Custom Category"));
            end;
        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateCustomCategory(var Item: Record Item; xItem: Record Item; var IsHandled: Boolean)
    begin
    end;
}