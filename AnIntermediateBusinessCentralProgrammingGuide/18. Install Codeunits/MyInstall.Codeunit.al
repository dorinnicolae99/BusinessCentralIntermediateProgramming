codeunit 50145 "My Install Codeunit"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        myAppInfo: ModuleInfo;
    begin
        //write code here for operations related to each company
        // Get info about the currently executing module
        NavApp.GetCurrentModuleInfo(myAppInfo);

        // A 'DataVersion' of 0.0.0.0 indicates a 'fresh/new' install
        if myAppInfo.DataVersion = Version.Create(0, 0, 0, 0) then
            HandleFreshInstall
        else
            // If not a fresh install, then we are Re-installing the same version of the extension
            HandleReinstall;
    end;

    trigger OnInstallAppPerDatabase()
    begin
        //write code here for database related operations
    end;

    local procedure HandleFreshInstall()
    var
        MySetup: Record "My Setup";
    begin
        if not MySetup.Get() then begin
            MySetup.Init();
            MySetup.Insert();
        end;

        MySetup."Is Installed" := true;
        MySetup.Modify();
    end;

    local procedure HandleReinstall()
    var
        MySetup: Record "My Setup";
    begin
        if not MySetup.Get() then begin
            MySetup.Init();
            MySetup.Insert();
        end;

        MySetup."Is Installed" := false;
        MySetup."Is Reinstalled" := true;
        MySetup.Modify();
    end;
}