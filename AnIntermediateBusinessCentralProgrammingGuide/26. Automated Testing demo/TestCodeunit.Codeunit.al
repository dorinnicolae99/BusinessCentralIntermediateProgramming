codeunit 50101 "Test Codeunit 1"
{
    Subtype = Test;

    [Test]
    internal procedure CheckItemSearchDescription()
    var
        Item: Record Item;
    begin
        //given: Item
        Item.Init();
        Item."No." := 'CHECK';
        Item.Insert();

        //when description is validated
        Item.Validate(Description, 'test text');

        //then search description needs to be identical but in upper case
        if Item."Search Description" <> GetUpperCaseItemDescription(Item) then
            Error('A different search description was expected: %1 . The search description that was found is : %2',
                GetUpperCaseItemDescription(Item), Item."Search Description")
    end;

    local procedure GetUpperCaseItemDescription(Item: Record Item): Code[100]
    begin
        exit(UpperCase(Item.Description));
    end;
}
