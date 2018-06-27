Param(
    [Parameter(mandatory=$True, ValueFromPipeline=$False, Position=0)]
    [string]$fileName
)

$maxLines = 50000

$ext = "csv"
$rootName = "split_"

$count = 1

$reader = $null

try {
    $reader = [io.file]::OpenText($fileName)

    try {
        $outputName = "{0}{1}.{2}" -f ($rootName, $count.ToString("000"), $ext)

        "Creating output file $outputName"
        $writer = [io.file]::CreateText($outputName)

        ++$count
        $lineCount = 0

        $headerRow = $reader.ReadLine()

        while( $reader.EndOfStream -ne $True ) {

            "Reading up to $maxLines lines."
            while( ($lineCount -lt $maxLines) -and ($reader.EndOfStream -ne $True)) {

                if($lineCount -eq 0) {
                    $writer.WriteLine( $headerRow )
                }

                $writer.WriteLine($reader.ReadLine())
                ++$lineCount
            }

            if($reader.EndOfStream -ne $True) {
                "Closing file"
                $writer.Dispose()

                $outputName = "{0}{1}.{2}" -f ($rootName, $count.ToString("000"), $ext)

                "Creating output file $outputName"
                $writer = [io.file]::CreateText($outputName)
                ++$count
                $lineCount = 0
            }
        }
    }
    Catch {
        $_
    }
    finally {
        $writer.Dispose()
    }
}
finally {
    $reader.Dispose()
}
exit 1
