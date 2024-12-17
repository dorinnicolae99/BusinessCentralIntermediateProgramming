codeunit 50140 "My Single Instance"
{
    SingleInstance = true;

    var
        MyText: Text;

    internal procedure SetText(ParText: Text)
    begin
        MyText := ParText;
    end;

    internal procedure GetText(): Text
    begin
        exit(MyText);
    end;
}