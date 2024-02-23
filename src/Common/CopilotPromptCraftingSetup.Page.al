page 58702 "Copilot Prompt Crafting Setup"
{
    ApplicationArea = All;
    Caption = 'Copilot Prompt Crafting Setup';
    PageType = Card;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(DeploymentFld; Deployment)
                {
                    Caption = 'Deployment Name';

                    trigger OnValidate()
                    begin
                        IsolatedStorageWrapper.SetDeployment(Deployment);
                        CurrPage.Update();
                    end;
                }
                field(EndpointFld; Endpoint)
                {
                    Caption = 'Endpoint';

                    trigger OnValidate()
                    begin
                        IsolatedStorageWrapper.SetEndpoint(Endpoint);
                        CurrPage.Update();
                    end;
                }
                field(OpenAISecretKeyFld; OpenAISecretKey)
                {
                    Caption = 'Azure OpenAI Key';
                    ExtendedDatatype = Masked;

                    trigger OnValidate()
                    begin
                        IsolatedStorageWrapper.SetSecretKey(OpenAISecretKey);
                        OpenAISecretKey := GetSecretMask();
                        CurrPage.Update();
                    end;
                }
            }
        }
    }

    var
        IsolatedStorageWrapper: Codeunit "Isolated Storage Wrapper";
        [NonDebuggable]
        OpenAISecretKey, Deployment, Endpoint : Text;

    trigger OnOpenPage()
    begin
        Deployment := IsolatedStorageWrapper.GetDeployment();
        Endpoint := IsolatedStorageWrapper.GetEndpoint();
        OpenAISecretKey := GetSecretMask();
    end;


    [NonDebuggable]
    internal procedure GetSecretMask(): Text
    begin
        if IsolatedStorageWrapper.SecretKeyExist() then
            exit('**********');
        exit('');
    end;
}
