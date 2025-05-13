table 50109 "Item Reviews"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; Sentiment; Text[20])
        {
            Caption = 'Sentiment';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Item No.", "Entry No.")
        {
            Clustered = true;
        }
    }
}