pageextension 50109 ItemCard extends "Item Card"
{
    layout
    {

    }

    actions
    {
        addfirst(Functions)
        {
            action(Reviews)
            {
                Caption = 'Reviews';
                Image = ReviewWorksheet;
                RunObject = page "Item Reviews";
                RunPageLink = "Item No." = field("No.");
            }
        }
    }
}