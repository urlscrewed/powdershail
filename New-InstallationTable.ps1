Function New-InstallationTable
{
<#

    .Synopsis

    Creates and returns a hash table containing key name pairs for

    PowerShellVersion
    DotNetVersion

    .DESCRIPTION

    .EXAMPLE

    New-InstallationTable;

#>

$ErrorActionPreference = "Stop";

$PSVersion = $PSVersionTable.PSVersion.Major;
$key = "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full";

  [Bool]$echo = $true;

    if(!(Test-Path -Path $key))
    {
        $parent = $(Split-Path -Path $key -Parent);
        $key = Join-Path $parent "Client";

        $Error.Clear();
        [Bool]$success = $true;
        try
        {
            $DotNetVersion = (Get-ItemProperty -Path $key | Select-Object -Property "Version").Version;
        }
        catch
        {
            $success = $false;
        }
        finally
        {
            if($success)
            {
                if($PSVersion -lt 5)
                {
                    Write-Host "PSVersion: $PSVersion" -ForegroundColor Red;
                }
                else
                {
                    Write-Host "PSVersion: $PSVersion" -ForegroundColor Green;
                }

                [Array]$items = $DotNetVersion.Split(".") | Select-Object -Index (0..1);
                $numberA = $items[0];
                $numberB = $items[1];

                if($numberB -ne 5 -and $numberA -eq 4)
                {
                    Write-Host "DotNetVersion: $DotNetVersion" -ForegroundColor Red;
                }
                else
                {
                    Write-Host "DotNetVersion: $DotNetVersion" -ForegroundColor Green;
                }

                
                #Write-Output -InputObject "DotNet Version: $DotNetVersion";
                [Bool]$echo = $false;

                #$hash = [ordered]@{
                #
                #   PowerShellVersion = "$PSVersion"
                #   DotNetVersion = "$DotNetVersion"
                #
                #}

                $hash = New-Object System.Collections.Specialized.OrderedDictionary;
                $hash.Add("PowerShellVersion","$PSVersion")
                $hash.Add("DotNetVersion","$DotNetVersion")


            }
            else
            {
            
            }
        }

        if($success)
        {
            return $hash;
        }
    }
    else
    {
    
    }
        $Error.Clear();
        [Bool]$success = $true;
        try
        {
            $DotNetVersion = (Get-ItemProperty -Path $key | Select-Object -Property "Version").Version;
        }
        catch
        {
            $success = $false;
        }
        finally
        {
            if($success)
            {
                if($PSVersion -lt 5)
                {
                    Write-Host "PSVersion: $PSVersion" -ForegroundColor Red;
                }
                else
                {
                    Write-Host "PSVersion: $PSVersion" -ForegroundColor Green;
                }

                [Array]$items = $DotNetVersion.Split(".") | Select-Object -Index (0..1);
                $numberA = $items[0];
                $numberB = $items[1];

                if($numberB -ne 5 -and $numberA -eq 4)
                {
                    Write-Host "DotNetVersion: $DotNetVersion" -ForegroundColor Red;
                }
                else
                {
                    Write-Host "DotNetVersion: $DotNetVersion" -ForegroundColor Green;
                }

              
                #Write-Output -InputObject "DotNet Version: $DotNetVersion";
                [Bool]$echo = $false;

                #$hash = [ordered]@{
                #
                #   PowerShellVersion = "$PSVersion"
                #   DotNetVersion = "$DotNetVersion"
                #
                #}

                $hash = New-Object System.Collections.Specialized.OrderedDictionary;
                $hash.Add("PowerShellVersion","$PSVersion")
                $hash.Add("DotNetVersion","$DotNetVersion")


            }
            else
            {
            
            }
        }

        if($success)
        {
            return $hash;
        }





#$DotNetVersion = (Get-ItemProperty -Path $key | Select-Object -Property Version).Version;
    if($echo)
    {
        Write-Output -InputObject "PowerShell Version: $PSVersion" ;
        Write-Output -InputObject "    DotNet Version: $DotNetVersion ";
    }


}
