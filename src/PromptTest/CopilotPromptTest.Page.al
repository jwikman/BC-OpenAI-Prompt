namespace CopilotPromptCrafting.PromptTest;

using CopilotPromptCrafting.PromptTest.History;
using CopilotPromptCrafting.Common;

page 58701 "Copilot Prompt Test"
{
    PageType = Card;
    Extensible = false;
    Caption = 'Test prompts with Copilot';
    UsageCategory = Tasks;
    ApplicationArea = All;
    SaveValues = true;

    layout
    {
        area(Content)
        {
            group(UserPromptGrp)
            {
                Caption = 'User Prompt';
                field(InputPromptField; UserPromptText)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        UpdateTokenCount();
                    end;
                }
            }
            group(SystemPromptGrp)
            {
                Caption = 'System Prompt';
                field(SystemPromptField; SystemPromptText)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        UpdateTokenCount();
                    end;
                }
            }
            group(ResultGrp)
            {
                Caption = 'Result';
                field(ResultField; ResultText)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    MultiLine = true;
                }
            }
            group(TokenGrp)
            {
                Caption = 'Tokens';
                field(TokenCountField; TokenCount)
                {
                    ApplicationArea = All;
                    Caption = 'Token Count';
                    Editable = false;
                }
                field(TotalTokenCountField; TotalTokenCount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Token Count';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Generate)
            {
                Caption = 'Generate';
                Image = Sparkle;

                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }
            action(SaveToHistory)
            {
                Caption = 'Save to History';
                Image = SaveViewAs;
                Enabled = ResultText <> '';

                trigger OnAction()
                var
                    PromptHistoryMgt: Codeunit "Prompt History Mgt.";
                begin
                    PromptHistoryMgt.SaveToHistory(SystemPromptText, UserPromptText, ResultText);
                end;
            }
            action(ViewUserPrompt)
            {
                Caption = 'View User Prompt';
                Image = View;
                Enabled = UserPromptText <> '';

                trigger OnAction()
                begin
                    Message(UserPromptText);
                end;
            }
            action(ViewSystemPrompt)
            {
                Caption = 'View System Prompt';
                Image = View;
                Enabled = SystemPromptText <> '';

                trigger OnAction()
                begin
                    Message(SystemPromptText);
                end;
            }
            action(ShowResult)
            {
                Caption = 'Show Results';
                Image = View;
                Enabled = ResultText <> '';

                trigger OnAction()
                begin
                    Message(ResultText);
                end;
            }
            action(GetFromHistory)
            {
                Caption = 'Load from History';
                Image = History;

                trigger OnAction()
                var
                    PromptHistoryMgt: Codeunit "Prompt History Mgt.";
                begin
                    PromptHistoryMgt.GetFromHistory(SystemPromptText, UserPromptText);
                    UpdateTokenCount();
                end;
            }
        }
        area(Navigation)
        {
            action(ShowHistory)
            {
                Caption = 'Show History';
                Image = History;
                RunObject = Page "Prompt History List";
            }
            action(Settings)
            {
                Caption = 'Settings';
                Image = Setup;
                RunObject = Page "Copilot Prompt Crafting Setup";
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Generate_Promoted; Generate)
                {
                }
                actionref(SaveToHistory_Promoted; SaveToHistory)
                {
                }
                actionref(ViewUserPrompt_Promoted; ViewUserPrompt)
                {
                }
                actionref(ViewSystemPrompt_Promoted; ViewSystemPrompt)
                {
                }
                actionref(ShowResult_Promoted; ShowResult)
                {
                }
                actionref(GetFromHistory_Promoted; GetFromHistory)
                {
                }
                actionref(Settings_Promoted; Settings)
                {
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

    end;

    local procedure RunGeneration()
    var
        IsolatedStorageWrapper: Codeunit "Isolated Storage Wrapper";
        GeneratePromptResult: Codeunit "Generate Prompt Result";
        ProgressDialog: Dialog;
        Attempts: Integer;
    begin
        if not IsolatedStorageWrapper.IsConfigured() then
            ShowConfiguration();
        ResultText := '';
        ProgressDialog.Open(GeneratingTextDialogTxt);
        GeneratePromptResult.SetPrompts(SystemPromptText, UserPromptText);


        for Attempts := 0 to 3 do
            if GeneratePromptResult.Run() then begin
                GeneratePromptResult.GetResult();
                ResultText := GeneratePromptResult.GetResult();
                UpdateTotalTokenCount();
                exit;
            end;

        if GetLastErrorText() = '' then
            Error(SomethingWentWrongErr)
        else
            Error(SomethingWentWrongWithLatestErr, GetLastErrorText());
    end;

    local procedure ShowConfiguration()
    var
        ConfigureQst: Label 'It seems as this is the first time you are using the Copilot Prompt Crafting extension. Do you want to configure the extension now?';
        ConfigureErr: Label 'The Copilot Prompt Crafting extension is not configured. Please configure the extension to use it.';
    begin
        if Confirm(ConfigureQst) then begin
            Page.Run(Page::"Copilot Prompt Crafting Setup");
            Error('');
        end else
            Error(ConfigureErr);
    end;

    local procedure UpdateTotalTokenCount()
    var
        SimplifiedCopilotChat: Codeunit "Copilot Chat Mgt.";
    begin
        TotalTokenCount := SimplifiedCopilotChat.PreciseTokenCount(UserPromptText + SystemPromptText + ResultText);
    end;

    local procedure UpdateTokenCount()
    var
        SimplifiedCopilotChat: Codeunit "Copilot Chat Mgt.";
    begin
        Clear(ResultText);
        Clear(TotalTokenCount);
        TokenCount := SimplifiedCopilotChat.PreciseTokenCount(UserPromptText + SystemPromptText);
    end;


    var
        GeneratingTextDialogTxt: Label 'Generating with Copilot...';
        SomethingWentWrongErr: Label 'Something went wrong. Please try again.';
        SomethingWentWrongWithLatestErr: Label 'Something went wrong. Please try again. The latest error is: %1', Comment = '%1=Error message';
        UserPromptText: Text;
        SystemPromptText: Text;
        ResultText: Text;
        TokenCount, TotalTokenCount : Integer;
}