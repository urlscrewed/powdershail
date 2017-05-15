


$ErrorActionPreference = "Stop";
[Bool]$success = $false;
$Error.Clear()

    try
    {
        choco
    }
    catch
    {
        $success = $false;
    }
    finally
    {
        if($success)
        {
            choco feature enable -n=allowGlobalCOnfirmation
            choco install dotnet4.5
        }
        else
        {
            Write-Output -InputObject "Chocolatey not found";
        }
    }


