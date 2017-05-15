$DebugPreference = "Continue";
$ErrorActionPreference = "Stop";

$ExecutionPolicy = Get-ExecutionPolicy

    if($ExecutionPolicy -ne "RemoteSigned")
    {
        $Error.Clear();
        [Bool]$success = $true;
        try
        {
            Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force -Verbose;
        }
        catch
        {
            Write-Host "Execution Policy needed to be set to RemoteSigned" -ForegroundColor Magenta;
            Start-Process PowerShell
            Start-Sleep -Seconds 5;
            exit;
             
        }
    }
    
    [Bool]$IsInstalled= $true;
    $Error.Clear();
    try
    {
        choco
    }
    catch
    {
            $IsInstalled = $false;
    }
    finally
    {
        if(!$IsInstalled)
        {
            [Bool]$success = $true;
            $Error.Clear();
            try
            {
                    $Resource = "https://www.chocolatey.org/install.ps1";
                    Invoke-Expression ((New-Object Net.WebClient).DownloadString("$Resource"));
            }
            catch
            {
                    $success = $false;
                    $ex = $Error | Select-Object -Index 0
                    $exType = $ex.Exception.GetType().FullName;
                    $Host.UI.WriteErrorLine("$exType");
            }
            finally
            {
                if($success)
                {
                    Start-Process PowerShell
                    exit;
                }
                else
                {
                    Write-Debug -Message "Could not access chocolatey resource $Resource ";
                }
            }
        }
        else
        {
            $InstallDir = $env:ChocolateyInstall;
            Write-Output "Chocolatey installation found at: $InstallDir";
        }
    }
