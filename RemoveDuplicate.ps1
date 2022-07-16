#RemoveDuplicate.ps1
$file = "/media/mart/windata/devops/ipevtv/tr.m3u"

$content = Get-Content -Path $file
$csv = $m3u.Split(";")

#$aj = $content -replace "`n" , ";"
$aj = $content -join ";"


$csvLike = [regex]::matches($aj, '(#EXTINF:0)(.*?)(m3u8;)').value


$newContent = @()

Clear-Host

foreach ($line in $csvLike  ) {
    # $line
    $tvname = [regex]::match($line, '(?<=\"\,)(.+?)(?=;)').value
    $groupname = [regex]::match($line, '(?<=title\=\")(.+?)(?=\")').value
    $groupname = $groupname -replace "/2" -replace "/1" -replace '\|TR\| ', '[TR] '
    $groupname
    $line = $line -replace '(?<=title\=\")(.+?)(?=\")', $groupname
    if ($newContent -match $tvname) {
        "duplicate allready exists"

    }
    else {
        #"hier Füllen"
        $newContent += $line
    }
    $newContent.count
    #$newContent

}



#<# output new file

[System.IO.Fileinfo]$newfile = "/media/mart/windata/devops/ipevtv/clean.tr.m3u"
"#EXTM3U" | Set-Content $newfile -Force

$cleanedcontent = $newContent.Split(";") | Where-Object { $_.trim() -ne "" }

$cleanedcontent | Out-File $newfile -Append
#>
