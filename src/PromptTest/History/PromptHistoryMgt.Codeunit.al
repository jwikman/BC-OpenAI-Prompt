namespace CopilotPromptCrafting.PromptTest.History;

codeunit 58705 "Prompt History Mgt."
{

    procedure SaveToHistory(SystemPrompt: Text; UserPrompt: Text; Result: Text)
    var
        PromptHistory: Record "Prompt History";
        DescriptionPrompt: Page "Description Prompt";
        BlobOutStream: OutStream;
        Description: Text[50];
    begin
        if DescriptionPrompt.RunModal() <> Action::OK then
            exit;
        Description := DescriptionPrompt.GetDescription();
        if Description = '' then
            exit;
        PromptHistory.Init();
        PromptHistory.Description := Description;
        PromptHistory."System Prompt Text" := CopyStr(SystemPrompt, 1, MaxStrLen(PromptHistory."System Prompt Text"));
        PromptHistory."User Prompt Text" := CopyStr(UserPrompt, 1, MaxStrLen(PromptHistory."User Prompt Text"));
        PromptHistory."Result Text" := CopyStr(Result, 1, MaxStrLen(PromptHistory."Result Text"));
        PromptHistory."System Prompt".CreateOutStream(BlobOutStream, TextEncoding::UTF8);
        BlobOutStream.WriteText(SystemPrompt);
        Clear(BlobOutStream);
        PromptHistory."User Prompt".CreateOutStream(BlobOutStream, TextEncoding::UTF8);
        BlobOutStream.WriteText(UserPrompt);
        Clear(BlobOutStream);
        PromptHistory.Result.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
        BlobOutStream.WriteText(Result);
        Clear(BlobOutStream);
        PromptHistory.Insert(true);
        PromptHistory.SetRecFilter();
    end;

    procedure GetFromHistory(var SystemPrompt: Text; var UserPrompt: Text)
    var
        PromptHistory: Record "Prompt History";
        Dummy: Text;
    begin
        if Page.RunModal(Page::"Prompt History List", PromptHistory) <> Action::LookupOK then
            exit;
        PromptHistory.GetData(SystemPrompt, UserPrompt, Dummy);
    end;
}
