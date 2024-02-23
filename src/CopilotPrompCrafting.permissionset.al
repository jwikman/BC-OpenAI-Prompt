permissionset 58700 CopilotPrompCrafting
{
    Caption = 'Copilot Prompt Crafting';
    Assignable = true;
    Permissions =
        tabledata "Prompt History" = RIMD,
        table "Prompt History" = X,
        codeunit "Copilot Chat Mgt." = X,
        codeunit "Generate Prompt Result" = X,
        codeunit "Isolated Storage Wrapper" = X,
        codeunit "Prompt History Mgt." = X,
        codeunit "Secrets And Capabilities Setup" = X,
        page "Copilot Prompt Test" = X,
        page "Description Prompt" = X,
        page "Prompt History" = X,
        page "Prompt History List" = X;
}