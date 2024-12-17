tableextension 50101 "Item Jnl Line" extends "Item Journal Line"
{
    internal procedure CheckLine()
    var
        ErrorMessageManagement: Codeunit "Error Message Management";
        ErrorMessageHandler: Codeunit "Error Message Handler";
    begin
        ErrorMessageManagement.Activate(ErrorMessageHandler);

        PerformCheck();

        if ErrorMessageHandler.HasErrors() then
            ErrorMessageHandler.ShowErrors()
        else
            Message('The line is ok.');
    end;

    local procedure PerformCheck()
    var
        ErrorMessageManagement: Codeunit "Error Message Management";
    begin
        if Rec."Item No." = '' then
            ErrorMessageManagement.LogSimpleErrorMessage('Item No. should have a value.');

        if Rec."Location Code" = '' then
            ErrorMessageManagement.LogSimpleErrorMessage('Location Code should be filled.');

        if Rec.Quantity = 0 then
            ErrorMessageManagement.LogError(Rec, 'Please give a quantity.', 'BLOCKED CUSTOMER');
    end;
}