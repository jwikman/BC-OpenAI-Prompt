page 58703 "Html Viewer"
{
    ApplicationArea = All;
    Caption = 'Html Viewer';
    Editable = false;
    PageType = Card;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            usercontrol(HtmlCtrl; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
            {
                trigger Callback(data: Text)
                begin
                end;

                trigger ControlAddInReady(callbackUrl: Text)
                begin
                    CurrPage.HtmlCtrl.LinksOpenInNewWindow();
                    CurrPage.HtmlCtrl.SetContent(HTMLContent);
                end;

                trigger DocumentReady()
                begin
                end;

                trigger Refresh(callbackUrl: Text)
                begin
                    CurrPage.HtmlCtrl.LinksOpenInNewWindow();
                    CurrPage.HtmlCtrl.SetContent(HTMLContent);
                end;
            }
        }
    }

    var
        HTMLContent: Text;

    procedure SetContent(NewHTMLContent: Text);
    var
        LineFeed: Char;
    begin
        LineFeed := 10;
        HTMLContent := NewHTMLContent.Replace(LineFeed, '<br />');
    end;
}
