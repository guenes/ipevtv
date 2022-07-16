$csv = @'
Column1  Column2
A  Data1
A  Data2
A  Data3
B  Data4
B  Data5
C  Data6
C  Data7
E  Data8
E  Data9
E  Data10
E  Data11
'@ -replace ' +', ',' | ConvertFrom-Csv


$csv | Group-Object Column1 | ForEach-Object {

    $i = $true

    $_.Group.foreach({

            if (-not $i) {
                $_.Column1 = ''
            }

            $i = $false
        })
}
