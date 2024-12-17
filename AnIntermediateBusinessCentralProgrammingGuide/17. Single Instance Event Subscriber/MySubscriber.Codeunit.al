codeunit 50141 "My Subscriber"
{
    SingleInstance = true;

    var
        MyText: Text;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnBeforePostSalesOrder, '', false, false)]
    local procedure OnBeforePostSalesOrder(var SalesHeader: Record "Sales Header")
    begin
        MyText := 'Posted from Sales Order ' + SalesHeader."No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertItemLedgEntry, '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        if MyText = '' then
            exit;

        if ItemLedgerEntry.Description = '' then
            ItemLedgerEntry.Description := MyText
        else
            ItemLedgerEntry.Description := ItemLedgerEntry.Description + ' ' + MyText;

        MyText := '';
    end;
}