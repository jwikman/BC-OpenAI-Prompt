namespace CopilotPromptCrafting.PromptTest;

using CopilotPromptCrafting.Common;

codeunit 58704 "Generate Prompt Result"
{
    trigger OnRun()
    begin
        GenerateProposal();
    end;

    procedure SetPrompts(SystemPromptText: Text; InputUserPrompt: Text)
    begin
        UserPrompt := InputUserPrompt;
        SystemPrompt := SystemPromptText;
    end;

    procedure GetResult(): Text
    begin
        exit(ResultTxt);
    end;

    local procedure GenerateProposal()
    var
        SimplifiedCopilotChat: Codeunit "Copilot Chat Mgt.";
    begin
        ResultTxt := SimplifiedCopilotChat.Chat(SystemPrompt, UserPrompt);
    end;


    var
        ResultTxt: Text;
        UserPrompt: Text;
        SystemPrompt: Text;
}