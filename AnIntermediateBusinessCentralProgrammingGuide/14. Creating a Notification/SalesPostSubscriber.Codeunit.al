codeunit 50108 "Sales Post Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header")
    var
        MyNotification: Notification;
    begin
        if SalesHeader."Last Shipping No." = '' then
            exit;

        MyNotification.Message(StrSubstNo('The Shipment %1 was posted.', SalesHeader."Last Shipping No."));
        MyNotification.Scope := NotificationScope::LocalScope;
        MyNotification.AddAction('Open Shipment', Codeunit::"Notification Codeunit", 'OpenShipmentFromNotification');
        MyNotification.SetData('ShipmentNo', SalesHeader."Last Shipping No.");
        MyNotification.Send();
    end;

}