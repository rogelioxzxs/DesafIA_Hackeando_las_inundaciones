$ErrorActionPreference = 'Stop'
$repositoryPath = 'C:\Users\rogel\OneDrive\Documentos\GitHub\DesafIA_Hackeando_las_inundaciones'
$sourcePath = Join-Path $PSScriptRoot '..\work\dist'
if (-not (Test-Path -LiteralPath (Join-Path $repositoryPath '.git'))) { throw 'No se encontro el repositorio esperado.' }
if (-not (Test-Path -LiteralPath (Join-Path $sourcePath 'index.html'))) { throw 'No se encontro la pagina preparada.' }
$itemsToCopy = @('index.html', 'style.css', 'app.js', 'assets')
foreach ($itemName in $itemsToCopy) {
    $destinationPath = Join-Path $repositoryPath $itemName
    if (Test-Path -LiteralPath $destinationPath) { throw "Ya existe $destinationPath. No se sobrescribio ningun archivo." }
}
if (Test-Path -LiteralPath (Join-Path $repositoryPath 'vercel.json')) { throw 'Ya existe vercel.json. No se sobrescribio ningun archivo.' }
foreach ($itemName in $itemsToCopy) {
    Copy-Item -LiteralPath (Join-Path $sourcePath $itemName) -Destination $repositoryPath -Recurse
}
'{"cleanUrls":true}' | Set-Content -LiteralPath (Join-Path $repositoryPath 'vercel.json') -Encoding utf8
Write-Host 'Pagina copiada. Abre GitHub Desktop, crea el commit y pulsa Publish branch o Push origin.'
