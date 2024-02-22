namespace CopilotPromptCrafting.PromptTest.History;

page 58704 "Prompt History List"
{
    ApplicationArea = All;
    Caption = 'Prompt History List';
    CardPageId = "Prompt History";
    Editable = false;
    PageType = List;
    SourceTable = "Prompt History";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("User Prompt Text"; Rec."User Prompt Text")
                {
                }
                field("System Prompt Text"; Rec."System Prompt Text")
                {
                }
                field("Result Text"; Rec."Result Text")
                {
                }
            }
        }
    }
}
