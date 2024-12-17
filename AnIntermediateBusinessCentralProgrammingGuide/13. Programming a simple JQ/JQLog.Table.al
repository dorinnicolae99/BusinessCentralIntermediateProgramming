table 50100 "JQ Log"
{
    Caption = 'JQ Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "Description"; Text[80])
        {
            Caption = 'Description';
        }
        field(3; "Date and Time"; DateTime)
        {
            Caption = 'Date and Time';
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