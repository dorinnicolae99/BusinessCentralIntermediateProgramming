codeunit 50141 "My Subscriber"
{
    [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnBeforePostSalesOrder, '', false, false)]
    local procedure OnBeforePostSalesOrder(var SalesHeader: Record "Sales Header")
    var
        MySingleInstance: Codeunit "My Single Instance";
    begin
        MySingleInstance.SetText('Posted from Sales Order ' + SalesHeader."No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertItemLedgEntry, '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry")
    var
        MySingleInstance: Codeunit "My Single Instance";
    begin
        if MySingleInstance.GetText() = '' then
            exit;

        if ItemLedgerEntry.Description = '' then
            ItemLedgerEntry.Description := MySingleInstance.GetText()
        else
            ItemLedgerEntry.Description := ItemLedgerEntry.Description + ' ' + MySingleInstance.GetText();

        MySingleInstance.SetText('');
    end;
}