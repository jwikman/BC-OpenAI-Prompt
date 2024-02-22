namespace CopilotPromptCrafting.Common;

using System.AI;
using System.RestClient;

codeunit 58703 "Simplified Copilot Chat"
{
    procedure Chat(SystemPrompt: Text; UserPrompt: Text): Text
    var
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
        IsolatedStorageWrapper: Codeunit "Isolated Storage Wrapper";
        Result: Text;
    begin
        AzureOpenAI.SetAuthorization(Enum::"AOAI Model Type"::"Chat Completions", IsolatedStorageWrapper.GetEndpoint(), IsolatedStorageWrapper.GetDeployment(), IsolatedStorageWrapper.GetSecretKey());

        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"Test AOAI Prompts");

        AOAIChatCompletionParams.SetMaxTokens(2500);
        AOAIChatCompletionParams.SetTemperature(0); // TODO: Let user select temperature


        AOAIChatMessages.AddSystemMessage(SystemPrompt);
        AOAIChatMessages.AddUserMessage(UserPrompt);

        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);

        if AOAIOperationResponse.IsSuccess() then
            Result := AOAIChatMessages.GetLastMessage()
        else
            Error(AOAIOperationResponse.GetError());

        exit(Result);
    end;

    procedure PreciseTokenCount(Input: Text): Integer
    var
        RestClient: Codeunit "Rest Client";
        Content: Codeunit "Http Content";
        JContent: JsonObject;
        JTokenCount: JsonToken;
        UriTxt: Label 'https://azure-openai-tokenizer.azurewebsites.net/api/tokensCount', Locked = true;
    begin
        JContent.Add('text', Input);
        Content.Create(JContent);
        RestClient.Send("Http Method"::GET, UriTxt, Content).GetContent().AsJson().AsObject().Get('tokensCount', JTokenCount);
        exit(JTokenCount.AsValue().AsInteger());
    end;
}