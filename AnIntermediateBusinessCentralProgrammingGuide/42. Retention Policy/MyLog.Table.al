table 50100 "My Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Message"; Text[50])
        {
            Caption = 'Message';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Closed;
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