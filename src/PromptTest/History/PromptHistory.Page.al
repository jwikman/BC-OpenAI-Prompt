namespace CopilotPromptCrafting.PromptTest.History;

page 58705 "Prompt History"
{
    ApplicationArea = All;
    Caption = 'Prompt History';
    PageType = Card;
    SourceTable = "Prompt History";
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = true;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(ID; Rec.ID)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
            group(UserPromptGrp)
            {
                Caption = 'User Prompt';

                field("User Prompt"; UserPrompt)
                {
                    ShowCaption = false;
                    Editable = false;
                    MultiLine = true;
                }
            }
            group(SystemPromptGrp)
            {
                Caption = 'System Prompt';

                field("System Prompt"; SystemPrompt)
                {
                    ShowCaption = false;
                    Editable = false;
                    MultiLine = true;
                }
            }
            group(ResultGrp)
            {
                Caption = 'Result';

                field(Result; Result)
                {
                    ShowCaption = false;
                    Editable = false;
                    MultiLine = true;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.GetData(SystemPrompt, UserPrompt, Result);
    end;

    var
        UserPrompt, SystemPrompt, Result : Text;
}
