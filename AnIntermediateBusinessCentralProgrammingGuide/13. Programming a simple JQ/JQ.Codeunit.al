codeunit 50100 JQ
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        JQLog: Record "JQ Log";
        ItemCard: Page "Item Card";
    begin
        JQLog.Init();
        JQLog.Description := StrSubstNo('Running from object %1', Rec."Object Caption to Run");
        JQLog."Date and Time" := CurrentDateTime();
        JQLog.Insert();
    end;
}