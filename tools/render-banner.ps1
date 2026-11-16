Add-Type -AssemblyName System.Drawing
$root = Split-Path $PSScriptRoot -Parent
$bitmap = New-Object System.Drawing.Bitmap 1200,420
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$fontCollection = [System.Drawing.Text.PrivateFontCollection]::new()
$fontCollection.AddFontFile((Join-Path $root 'assets/fonts/GoogleSans.ttf'))
$googleSans = $fontCollection.Families[0]
if ($googleSans.Name -notlike 'Google Sans*') { throw 'Google Sans could not be loaded.' }
# Matching radial color fields in the PNG preview and portable SVG.
$graphics.Clear([System.Drawing.ColorTranslator]::FromHtml('#080808'))
$parts = [System.Collections.Generic.List[string]]::new()
$parts.Add('<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="420" viewBox="0 0 1200 420" role="img" aria-labelledby="title desc"><title id="title">Hoang Phuc Hung — Gabriel Tommy</title><desc id="desc">White Google Sans lettering over soft pools of crimson on black. Welcome to my GitHub page. GabTommy2006. Gabriel Tommy.</desc><rect width="1200" height="420" fill="#080808"/>')
$fields = @(
    @{ X=1020; Y=42; RX=700; RY=390; Color='#D20A31' },
    @{ X=690; Y=460; RX=580; RY=310; Color='#8C0928' },
    @{ X=1270; Y=415; RX=430; RY=300; Color='#C90928' }
)
$fieldIndex=0
foreach ($field in $fields) {
    $color=[System.Drawing.ColorTranslator]::FromHtml($field.Color)
    $layer=[System.Drawing.Bitmap]::new(1200,420)
    for ($y=0; $y -lt 420; $y++) {
        for ($x=0; $x -lt 1200; $x++) {
            $r2=[Math]::Pow(($x-$field.X)/$field.RX,2)+[Math]::Pow(($y-$field.Y)/$field.RY,2)
            if ($r2 -lt 1) {
                $alpha=[int][Math]::Round(255*[Math]::Pow(1-$r2,2))
                $layer.SetPixel($x,$y,[System.Drawing.Color]::FromArgb($alpha,$color))
            }
        }
    }
    $graphics.DrawImageUnscaled($layer,0,0)
    $layer.Dispose()
    $stops=[System.Text.StringBuilder]::new()
    for ($step=0; $step -le 20; $step++) {
        $radius=$step/20.0
        $opacity=[Math]::Pow(1-$radius*$radius,2).ToString('0.####',[System.Globalization.CultureInfo]::InvariantCulture)
        [void]$stops.Append('<stop offset="'+($step*5)+'%" stop-color="'+$field.Color+'" stop-opacity="'+$opacity+'"/>')
    }
    $parts.Add('<defs><radialGradient id="pool'+$fieldIndex+'">'+$stops.ToString()+'</radialGradient></defs><ellipse cx="'+$field.X+'" cy="'+$field.Y+'" rx="'+$field.RX+'" ry="'+$field.RY+'" fill="url(#pool'+$fieldIndex+')"/>')
    $fieldIndex++
}
function Add-Lettering([string]$label, [string]$family, [int]$style, [single]$size, [single]$x, [single]$y, [string]$color) {
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new([System.Drawing.Drawing2D.FillMode]::Winding)
    $font = $googleSans
    $path.AddString($label,$font,$style,$size,[System.Drawing.PointF]::new($x,$y),[System.Drawing.StringFormat]::GenericTypographic)
    $brush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml($color))
    $graphics.FillPath($brush,$path)
    $data = [System.Text.StringBuilder]::new()
    $points = $path.PathPoints; $types = $path.PathTypes
    $culture = [System.Globalization.CultureInfo]::InvariantCulture
    for ($i=0; $i -lt $points.Length; $i++) {
        $kind = $types[$i] -band 7
        $point = $points[$i].X.ToString('0.##',$culture)+','+$points[$i].Y.ToString('0.##',$culture)
        if ($kind -eq 0) { [void]$data.Append('M'+$point) }
        elseif ($kind -eq 1) { [void]$data.Append('L'+$point) }
        elseif ($kind -eq 3) {
            [void]$data.Append('C'+$point+' '+$points[$i+1].X.ToString('0.##',$culture)+','+$points[$i+1].Y.ToString('0.##',$culture)+' '+$points[$i+2].X.ToString('0.##',$culture)+','+$points[$i+2].Y.ToString('0.##',$culture))
            $i+=2
        }
        if (($types[$i] -band 128) -ne 0) { [void]$data.Append('Z') }
    }
    $parts.Add('<path fill="'+$color+'" d="'+$data.ToString()+'"/>')
    $brush.Dispose(); $path.Dispose()
}
Add-Lettering 'Hoang Phuc Hung' 'Google Sans' 1 82 64 72 '#FFFFFF'
Add-Lettering 'Welcome to my GitHub page.' 'Google Sans' 0 30 68 194 '#FFFFFF'
Add-Lettering '@GabTommy2006' 'Google Sans' 0 23 68 326 '#FFFFFF'
Add-Lettering 'GABRIEL TOMMY' 'Google Sans' 1 23 914 326 '#FFFFFF'
$parts.Add('</svg>')
[System.IO.File]::WriteAllText((Join-Path $root 'assets/profile-banner.svg'),($parts -join "`n"),[System.Text.UTF8Encoding]::new($false))
$bitmap.Save((Join-Path $root 'assets/profile-banner.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$graphics.Dispose(); $bitmap.Dispose(); $fontCollection.Dispose()
'Banner exported as outlined SVG and PNG (1200 x 420).'
