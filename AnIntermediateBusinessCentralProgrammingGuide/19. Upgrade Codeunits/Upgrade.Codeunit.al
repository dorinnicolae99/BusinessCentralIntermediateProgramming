codeunit 50106 "My Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        CopyNewItemField();
    end;

    local procedure CopyNewItemField()
    var
        Item: Record Item;
        UpgradeTagMgt: Codeunit "Upgrade Tag";
        UpgradeTagDefiniton: Codeunit "Upgrade Tag Definition";
        DT: DataTransfer;
    begin
        if UpgradeTagMgt.HasUpgradeTag(UpgradeTagDefiniton.GetNewItemFieldUpgradeTag()) then
            exit;

        DT.SetTables(Database::Item, Database::Item);
        DT.AddSourceFilter(Item.FieldNo(Blocked), '=%1', false);
        DT.AddFieldValue(Item.FieldNo("Description 2"), Item.FieldNo("New Description"));
        DT.CopyFields();

        UpgradeTagMgt.SetUpgradeTag(UpgradeTagDefiniton.GetNewItemFieldUpgradeTag());
    end;
}