codeunit 50121 "Item Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::Item, OnBeforeValidateBaseUnitOfMeasure, '', false, false)]
    local procedure OnBeforeValidateBaseUnitOfMeasure(var Item: Record Item; xItem: Record Item; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        IsHandled := true;

        /*
        My new logic to handle the OnValidate trigger



        */
    end;
}