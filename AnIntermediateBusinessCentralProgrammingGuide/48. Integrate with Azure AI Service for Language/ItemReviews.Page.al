page 50109 "Item Reviews"
{
    Caption = 'Item Reviews';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Reviews";

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field(Description; Rec.Description)
                {
                }
                field(Sentiment; Rec.Sentiment)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AnalyzeSentiment)
            {
                ApplicationArea = All;
                Caption = 'Analyze Sentiment';
                Image = Interaction;

                trigger OnAction()
                var
                    GetAIAnalysis: Codeunit GetAIAnalysis;
                begin
                    Rec.Sentiment := GetAIAnalysis.GetSentiment(Rec.Description);
                    Rec.Modify();
                end;
            }
        }
    }
}