//Whith this solution you can copy the file to your bussiness central folder in OneDrive and open it in a new windows. 

pageextension 50100 SalesOrderExt extends "Sales Order"
{
    actions
    {
        addlast("O&rder")
        {
            action(OpenInOneDrive)
            {
                ApplicationArea = all;
                Caption = 'Open in One Drive';
                Image = Cloud;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedOnly = true;
                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    DocumentServiceMgt: Codeunit "Document Service Management";
                    InStr: InStream;
                begin
                    GetSalesOrder(TempBlob);
                    TempBlob.CreateInStream(InStr);
                    DocumentServiceMgt.OpenInOneDrive(StrSubstNo(SalesOrderName, Rec."No."), '.pdf', InStr);
                end;
            }

        }
    }
    var
        ShareOptionsEnable: Boolean;
        SalesOrderName: Label 'Sales Order %1';

    local procedure GetSalesOrder(var TempBlob: Codeunit "Temp Blob")
    var
        ReportSelections: Record "Report Selections";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        RecRef.SetRecFilter();
        ReportSelections.GetPdfReportForCust(TempBlob, ReportSelections.Usage::"S.Order", RecRef, rec."Sell-to Customer No.");

    end;
}