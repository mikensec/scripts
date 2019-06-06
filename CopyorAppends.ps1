#function looks for files in DestinationDir, if the files exist, then the content from SourceDir are appended to the files in DestinationDir if the name matches. 
function Acopy ($SourceDir, $DestinationDir) {
    Get-ChildItem $SourceDir -Recurse | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object ($_) {
        $SourceFile = $_.FullName
        $DestinationFile = $DestinationDir + $_ 
        if (Test-Path $DestinationFile) {
            Get-Content $SourceFile | Add-Content -Path $DestinationFile            
        }
        else {
            Copy-Item -Path $SourceFile -Destination $DestinationFile -Verbose -Force
        }
        
    }
}

    

