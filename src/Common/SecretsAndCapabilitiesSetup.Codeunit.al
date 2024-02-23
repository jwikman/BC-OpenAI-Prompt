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
        LearnMoreUrlTxt: Label 'https://github.com/jwikman/BC-OpenAI-Prompt/blob/main/README.md', Locked = true;
    begin
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Test AOAI Prompts") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Test AOAI Prompts", Enum::"Copilot Availability"::Preview, LearnMoreUrlTxt);
    end;
}