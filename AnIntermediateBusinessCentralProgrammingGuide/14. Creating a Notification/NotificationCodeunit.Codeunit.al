codeunit 50109 "Notification Codeunit"
{
    internal procedure OpenShipmentFromNotification(MyNotification: Notification)
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        PageManagement: Codeunit "Page Management";
    begin
        if not MyNotification.HasData('ShipmentNo') then
            exit;

        if not SalesShipmentHeader.Get(MyNotification.GetData('ShipmentNo')) then
            exit;

        PageManagement.PageRun(SalesShipmentHeader);
    end;

}