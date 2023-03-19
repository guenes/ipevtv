#RemoveDuplicate.ps1
#$file = "./tr.orginal.m3u"
$file = "./de2.m3u"

$content = Get-Content -Path $file

#$aj = $content -replace "`n" , ";"
$aj = $content -join ";"

#gruppiert link und meta info als eine zeile
$csvLike = [regex]::matches($aj, '(#EXTINF:-1)(.*?)(m3u8;)').value

$newContent = @()

#Clear-Host

foreach ($line in $csvLike  ) {
    # $line
    $tvname = [regex]::match($line, '(?<=\"\,)(.+?)(?=;)').value
    $groupname = [regex]::match($line, '(?<=title\=\")(.+?)(?=\")').value
    $groupname = $groupname -replace "/2" -replace "/1" -replace '\|TR\| ', '[TR] '
    $groupname
    $unique = $line -replace '(?<=title\=\")(.+?)(?=\")', ('[DE] ' + $groupname)
@"
$tvname
$groupname
$unique
"@
    # wenn der sender name schon exisitert, überpringe komplette zeile.
    if ($newContent -match $tvname) {
        "duplicate allready exists"

    }
    else {
        #"hier Füllen"
        $newContent += $unique
    }
       $newContent.count

}

#<#output new file

[System.IO.Fileinfo]$newfile = "./de.m3u"
"#EXTM3U" | Set-Content $newfile -Force

$cleanedcontent = $newContent.Split(";") | Where-Object { $_.trim() -ne "" }

#$cleanedcontent | Out-File $newfile -Append
#Copy-Item $newfile ./tr.m3u
#>
