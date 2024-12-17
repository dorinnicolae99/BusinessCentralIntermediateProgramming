pageextension 50100 "Customer Card Ext" extends "Customer Card"
{
    actions
    {
        addafter(NewSalesOrderAddin)
        {
            action(NewSalesOrderReqDeliveryDate)
            {
                ApplicationArea = All;
                Caption = 'Sales Order with Req. Delivery Date';
                Image = Document;
                ToolTip = 'Creates a sales order for the customer but also fills in the Requested Delivery Date field.';

                trigger OnAction()
                var
                    MyManualSubscriber: Codeunit "My Manual Subscriber";
                begin
                    BindSubscription(MyManualSubscriber);
                    Rec.CreateAndShowNewOrder();
                end;
            }
        }
    }
}