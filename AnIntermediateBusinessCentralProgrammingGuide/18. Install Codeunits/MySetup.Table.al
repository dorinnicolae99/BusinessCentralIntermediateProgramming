table 50145 "My Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Is Installed"; Boolean)
        {
            Caption = 'Is Installed';
            DataClassification = ToBeClassified;
        }
        field(3; "Is Reinstalled"; Boolean)
        {
            Caption = 'Is Reinstalled';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}