pageextension 50101 "Item Jnl" extends "Item Journal"
{
    actions
    {
        addafter("&Save as Standard Journal")
        {
            action(CheckLine)
            {
                ApplicationArea = All;
                Caption = 'Check Line';
                Image = CheckJournal;

                trigger OnAction()
                begin
                    Rec.CheckLine();
                end;
            }
        }
    }
}