table 50100 "Calculate Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Calculate Method"; Enum "Calculate Method")
        {
            Caption = 'Calculate Method';
        }
        field(3; Number1; Decimal)
        {
            Caption = 'Number1';
        }
        field(4; Number2; Decimal)
        {
            Caption = 'Number2';
        }
        field(5; Result; Decimal)
        {
            Caption = 'Result';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}