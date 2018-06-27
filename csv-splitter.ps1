Param(
    [Parameter(mandatory=$True, ValueFromPipeline=$False, Position=0)]
    [string]$fileName
)

$maxLines = 25
$ext = "csv"
$rootName = "split_"

$reader = new-object System.IO.StreamReader("$fileName")
$count = 1
$lineCount = 0
$outputName = "{0}{1}.{2}" -f ($rootName, $count, $ext)

# Copy header row to all output files
if(($headerRow = $reader.ReadLine()) -ne $null) {

    while(($line = $reader.ReadLine()) -ne $null)
    {
        ++$lineCount
        if($lineCount -eq 1) {
            Add-Content -path $outputName -value $headerRow
        }

        Add-Content -path $outputName -value $line
        if($lineCount -ge $maxLines)
        {
            ++$count
            $lineCount = 0
            $outputName = "{0}{1}.{2}" -f ($rootName, $count, $ext)
        }
    }

}

$reader.Close()
