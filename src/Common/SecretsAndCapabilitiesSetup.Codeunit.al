namespace CopilotPromptCrafting.Common;

using System.AI;

codeunit 58702 "Secrets And Capabilities Setup"
{
    Subtype = Install;
    InherentEntitlements = X;
    InherentPermissions = X;
    Access = Internal;

    trigger OnInstallAppPerDatabase()
    begin
        RegisterCapability();
    end;

    local procedure RegisterCapability()
    var
        CopilotCapability: Codeunit "Copilot Capability";
        IsolatedStorageWrapper: Codeunit "Isolated Storage Wrapper";
        LearnMoreUrlTxt: Label 'https://github.com/jwikman/BC-OpenAI-Prompt/blob/main/README.md', Locked = true;
    begin
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Test AOAI Prompts") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Test AOAI Prompts", Enum::"Copilot Availability"::Preview, LearnMoreUrlTxt);


        Error('Before installing this app, you need to set your own secrets below (in "SecretsAndCapabilitiesSetup.Codeunit.al"). Then delete this error message.');
        IsolatedStorageWrapper.SetSecretKey('your-secret-key-here');
        IsolatedStorageWrapper.SetDeployment('your-deployment-model-here');
        IsolatedStorageWrapper.SetEndpoint('your-endpoint-here');
    end;
}