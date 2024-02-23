namespace CopilotPromptCrafting.Common;

codeunit 58701 "Isolated Storage Wrapper"
{
    SingleInstance = true;
    Access = Internal;

    var
        IsolatedStorageSecretKeyKeyTok: Label 'CopilotPromptCraftingSecret', Locked = true;
        IsolatedStorageDeploymentKeyTok: Label 'CopilotPromptCraftingDeployment', Locked = true;
        IsolatedStorageEndpointKeyTok: Label 'CopilotPromptCraftingEndpoint', Locked = true;
        [NonDebuggable]
        SavedSecretKey, SavedDeployment, SavedEndpoint : Text;


    internal procedure SecretKeyExist(): Boolean
    begin
        exit(IsolatedStorage.Contains(IsolatedStorageSecretKeyKeyTok));
    end;

    [NonDebuggable]
    local procedure GetSecretKey() SecretKey: Text
    begin
        if SavedSecretKey <> '' then
            SecretKey := SavedSecretKey
        else begin
            if IsolatedStorage.Get(IsolatedStorageSecretKeyKeyTok, SecretKey) then;
            SavedSecretKey := SecretKey;
        end;
    end;


    [NonDebuggable]
    internal procedure GetDeployment() Deployment: Text
    begin
        if SavedDeployment <> '' then
            Deployment := SavedDeployment
        else begin
            if IsolatedStorage.Get(IsolatedStorageDeploymentKeyTok, Deployment) then;
            SavedDeployment := Deployment;
        end;
    end;

    [NonDebuggable]
    internal procedure GetEndpoint() Endpoint: Text
    begin
        if SavedEndpoint <> '' then
            Endpoint := SavedEndpoint
        else begin
            if IsolatedStorage.Get(IsolatedStorageEndpointKeyTok, Endpoint) then;
            SavedEndpoint := Endpoint;
        end;
    end;

    [NonDebuggable]
    internal procedure IsConfigured(): Boolean
    begin
        exit((GetSecretKey() <> '') and (GetDeployment() <> '') and (GetEndpoint() <> ''));
    end;

    [NonDebuggable]
    procedure SetSecretKey(SecretKey: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageSecretKeyKeyTok, SecretKey);
        Clear(SavedSecretKey)
    end;

    [NonDebuggable]
    procedure SetDeployment(Deployment: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageDeploymentKeyTok, Deployment);
        Clear(SavedDeployment);
    end;

    [NonDebuggable]
    procedure SetEndpoint(Endpoint: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageEndpointKeyTok, Endpoint);
        Clear(SavedEndpoint);
    end;

    [NonDebuggable]
    internal procedure SetAuthorization(AOAIModelType: Enum System.AI."AOAI Model Type"; AzureOpenAI: Codeunit System.AI."Azure OpenAI")
    begin
        AzureOpenAI.SetAuthorization(AOAIModelType, GetEndpoint(), GetDeployment(), GetSecretKey());
    end;


}