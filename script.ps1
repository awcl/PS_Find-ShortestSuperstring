function Minimum($a, $b) { return [Math]::Min($a, $b) }

function Find-OverlappingPair($str1, $str2) {
    $maxLen = [Int32]::MinValue
    $mergedStr = ""
    $len1 = $str1.Length
    $len2 = $str2.Length
    for ($i = 1; $i -le (Minimum $len1 $len2); $i++) {
        if ($str1.Substring($len1 - $i, $i) -eq $str2.Substring(0, $i) -and $maxLen -lt $i) {
            $maxLen = $i
            $mergedStr = $str1 + $str2.Substring($i)
        }
        if ($str1.Substring(0, $i) -eq $str2.Substring($len2 - $i, $i) -and $maxLen -lt $i) {
            $maxLen = $i
            $mergedStr = $str2 + $str1.Substring($i)
        }
    }
    return $maxLen, $mergedStr
}

function Find-ShortestSuperstring($arr) {
    while ($arr.Length -gt 1) {
        $maxLen = [Int32]::MinValue
        $l, $r = 0, 0
        $resStr = ""
        for ($i = 0; $i -lt $arr.Length; $i++) {
            for ($j = $i + 1; $j -lt $arr.Length; $j++) {
                $res, $str = Find-OverlappingPair $arr[$i] $arr[$j]
                if ($maxLen -lt $res) {
                    $maxLen = $res
                    $resStr = $str
                    $l, $r = $i, $j
                }
            }
        }
        if ($maxLen -eq [Int32]::MinValue) { 
            $arr[0] += $arr[-1]
        } else {
            $arr[$l] = $resStr
            $arr[$r] = $arr[-1]
        }
        $arr = $arr[0..($arr.Length - 2)]
    }
    return $arr[0]
}

$arr = 1..100 | ForEach-Object { $_.ToString() } # Arr of strings here :)
$shortestSuperstring = Find-ShortestSuperstring $arr
Write-Host "The Shortest Superstring is: $shortestSuperstring"
