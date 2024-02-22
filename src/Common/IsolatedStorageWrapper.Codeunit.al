namespace CopilotPromptCrafting.Common;

codeunit 58701 "Isolated Storage Wrapper"
{
    SingleInstance = true;
    Access = Internal;

    var
        IsolatedStorageSecretKeyKeyTok: Label 'CopilotPromptCraftingSecret', Locked = true;
        IsolatedStorageDeploymentKeyTok: Label 'CopilotPromptCraftingDeployment', Locked = true;
        IsolatedStorageEndpointKeyTok: Label 'CopilotPromptCraftingEndpoint', Locked = true;

    procedure GetSecretKey() SecretKey: Text
    begin
        IsolatedStorage.Get(IsolatedStorageSecretKeyKeyTok, SecretKey);
    end;

    procedure GetDeployment() Deployment: Text
    begin
        IsolatedStorage.Get(IsolatedStorageDeploymentKeyTok, Deployment);
    end;

    procedure GetEndpoint() Endpoint: Text
    begin
        IsolatedStorage.Get(IsolatedStorageEndpointKeyTok, Endpoint);
    end;

    procedure SetSecretKey(SecretKey: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageSecretKeyKeyTok, SecretKey);
    end;

    procedure SetDeployment(Deployment: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageDeploymentKeyTok, Deployment);
    end;

    procedure SetEndpoint(Endpoint: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageEndpointKeyTok, Endpoint);
    end;

}