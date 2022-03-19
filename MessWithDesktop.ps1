$percentChance = 60
$userDesktopPath = "C:\Users\Max\Desktop"; #Like C:\Users\Max\Desktop

Function ShouldProgramRun($percentChanceToRun) 
{
    $randomPercentChance = Get-Random -Maximum 100
    #Write-Host "Values: $randomPercentChance / $percentChanceToRun"
    if ( $randomPercentChance -lt $percentChanceToRun)
    {
        Write-Host "To Run"
        return $true
    } else 
    {
        Write-Host "Chance: $randomPercentChance / $percentChanceToRun"
        return $false
    }
}

#Should return file path of a shortcut (lnk file) on the user's desktop. Can return Null to mean no shortcuts exist that is not already set to a cup
Function GetFilePathOfRandomDesktopIconThatIsNotAlreadyACup() 
{
    Get-ChildItem $userDesktopPath -Filter *.lnk | 
    Foreach-Object {
        $currentFileFullPath = $_.FullName

        if ((IsCupIconsContainedInIconPath($currentFileFullPath)) -eq $false) #Ignore shortcuts that already have icon
        {
            Write-Host $currentFileFullPath
            return $currentFileFullPath
        } else 
        {
            
        }
    }
}

Function IsCupIconsContainedInIconPath($shortcutFileFullPath)
{
    $ShortcutFile = $shortcutFileFullPath
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
    $iconPath = $Shortcut.IconLocation

    if ($iconPath.Contains("CupIcons"))
    {
        return $true
    }
    else 
    {
        return $false
    }
}

Function ChangeDesktopShortcutIconToARandomCup($shortcutFileFullPath)
{
    if ($null -ne $shortcutFileFullPath) 
    {
        $cupNumber = Get-Random -Maximum 7 #cups are named cup1.ico, cup2.ico, etc. This will help choose a random one. 
        $ShortcutFile = $shortcutFileFullPath
        $WScriptShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
        $Shortcut.IconLocation = "D:\Projects\desktop_to_cup\CupIcons\cup$cupNumber.ico, 0"
        $Shortcut.Save()
    }
}

Function IsCurrentDesktopPictureAlreadyACup()
{

}

Function ChangeDesktopPictureToRandomCup()
{

}

#Write-Host("Should Run: $(ShouldProgramRun($percentChance))")


if (ShouldProgramRun($percentChance))
{
    Write-Host("Running. ")
} 
else 
{
    Write-Host("Not running. ")
    exit
}

$selectedShortcutPath = GetFilePathOfRandomDesktopIconThatIsNotAlreadyACup
ChangeDesktopShortcutIconToARandomCup($selectedShortcutPath)
#UpdateRandomIcon

#If no more icons to update
    #changeDesktopPicture

#IfNoDesktopPicture
    #create folders

#If Folders -gt 10 nad text file doesnt exist
    #create textfile

#If folders -gt 20 and text file exists
    #create textfile2