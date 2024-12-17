codeunit 50100 "My Manual Subscriber"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterOnInsert, '', false, false)]
    local procedure OnAfterOnInsert(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."Requested Delivery Date" := Today();
    end;
}