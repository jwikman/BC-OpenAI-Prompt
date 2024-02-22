namespace CopilotPromptCrafting.PromptTest.History;

page 58706 "Description Prompt"
{
    ApplicationArea = All;
    Caption = 'Description Prompt';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(DescriptionFld; Description)
            {
                Caption = 'Description';
            }
        }
    }

    procedure GetDescription(): Text[50]
    begin
        exit(Description);
    end;

    var
        Description: Text[50];
}
