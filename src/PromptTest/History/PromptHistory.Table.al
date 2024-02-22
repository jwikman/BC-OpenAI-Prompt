namespace CopilotPromptCrafting.PromptTest.History;

table 58700 "Prompt History"
{
    Caption = 'Prompt History';
    DataClassification = CustomerContent;
    LookupPageId = "Prompt History List";
    DrillDownPageId = "Prompt History List";

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(20; "System Prompt"; Blob)
        {
            Caption = 'System Prompt';
        }
        field(21; "System Prompt Text"; Text[100])
        {
            Caption = 'System Prompt Text';
        }
        field(30; "User Prompt"; Blob)
        {
            Caption = 'User Prompt';
        }
        field(31; "User Prompt Text"; Text[100])
        {
            Caption = 'User Prompt Text';
        }
        field(40; Result; Blob)
        {
            Caption = 'Result';
        }
        field(41; "Result Text"; Text[100])
        {
            Caption = 'Result Text';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    procedure GetData(var SystemPromptText: Text; var UserPromptText: Text; var ResultText: Text)
    var
        BlobInStream: InStream;
    begin
        Rec.CalcFields("System Prompt", "User Prompt", "Result");
        Rec.Result.CreateInStream(BlobInStream, TextEncoding::UTF8);
        BlobInStream.Read(ResultText);
        Rec."System Prompt".CreateInStream(BlobInStream, TextEncoding::UTF8);
        BlobInStream.Read(SystemPromptText);
        Rec."User Prompt".CreateInStream(BlobInStream, TextEncoding::UTF8);
        BlobInStream.Read(UserPromptText);
    end;
}
