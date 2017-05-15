$ErrorActionPreference = "Stop";

$Error.Clear();
$Path = "C:\Choco";

[Bool]$ChocolateyIsInstalled = $true;
[Bool]$success = $true;

$PackageDir = "$env:ProgramData\PS-Scripts";




    #Will create a PS-Scripts folder in C:\ProgramData because we are a security ninja;
    if(!(Test-Path -Path $PackageDir))
    {
        New-Item -Path $PackageDir -ItemType Directory | Out-Null;
        Set-Location -Path $PackageDir;
        Get-ChildItem
    }

$Packages = (Get-ChildItem -Path $PackageDir -Recurse)



$Error.Clear();    

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
            choco feature enable -n=allowGlobalConfirmation
            
            try
            {
                if(!(Test-Path -Path $Path))
                {
                    New-Item -Path $Path -ItemType Directory | Out-Null;
                    choco source add -n=Choco -s="C:\Choco"
                }
            }
            catch
            {
                $success = $false;
            }
                if($success)
                {
                    foreach($Package in $Packages)
                    {
                        $parent = Join-Path $PackageDir $Package
                        $leaf = (Get-ChildItem -Path $parent | Where-Object  {$_.Name -ilike "*.nupkg"} | Select-Object -Property Name).Name 

                        $nupkg = Join-Path $parent $leaf;

                        if(Test-Path -Path $nupkg)
                        {
                            if(!([String]::IsNullOrEmpty($nupkg)))
                            {
                                Move-Item -Path $nupkg -Destination "C:\Choco";
                                Write-Output "Moving new nukpg file to local chocolatey source.";
                            }
                        }
                    }     
                }
                else
                {
                
                }
            
        }
        else
        {
        
        }
    }

