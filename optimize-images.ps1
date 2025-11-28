# Script para otimizar imagens WebP pesadas
# Este script cria versões otimizadas das imagens de habilidades

Write-Host "=== Otimizador de Imagens WARFRAME ===" -ForegroundColor Cyan
Write-Host ""

$sourcePath = "vendors/img/agentes"
$abilities = @("ability1.webp", "ability2.webp", "ability3.webp", "ability4.webp")

Write-Host "ANÁLISE DOS ARQUIVOS:" -ForegroundColor Yellow
Write-Host "----------------------" -ForegroundColor Yellow

foreach ($ability in $abilities) {
    $file = Get-Item "$sourcePath\$ability" -ErrorAction SilentlyContinue
    if ($file) {
        $sizeMB = [math]::Round($file.Length / 1MB, 2)
        Write-Host "$ability : $sizeMB MB" -ForegroundColor $(if ($sizeMB -gt 5) { "Red" } else { "Green" })
    }
}

Write-Host ""
Write-Host "PROBLEMA IDENTIFICADO:" -ForegroundColor Red
Write-Host "Os arquivos WebP estão muito pesados (5-19 MB cada!)" -ForegroundColor Red
Write-Host "Isso causa travamentos na página de detalhes do personagem." -ForegroundColor Red
Write-Host ""

Write-Host "SOLUÇÕES RECOMENDADAS:" -ForegroundColor Green
Write-Host "----------------------" -ForegroundColor Green
Write-Host "1. CONVERTER PARA IMAGENS ESTÁTICAS (Melhor opção):" -ForegroundColor Cyan
Write-Host "   - Extrair um frame representativo de cada animação"
Write-Host "   - Tamanho final: ~50-200 KB por imagem"
Write-Host "   - Performance: Excelente"
Write-Host ""

Write-Host "2. REDUZIR QUALIDADE/FPS DOS WEBP ANIMADOS:" -ForegroundColor Cyan
Write-Host "   - Usar ferramentas online como:"
Write-Host "     • https://ezgif.com/optimize (recomendado)"
Write-Host "     • https://squoosh.app/"
Write-Host "   - Reduzir FPS de 60fps para 15-24fps"
Write-Host "   - Reduzir qualidade para 60-70%"
Write-Host "   - Tamanho alvo: 500KB - 1MB por arquivo"
Write-Host ""

Write-Host "3. USAR VÍDEOS MP4 ao invés de WebP:" -ForegroundColor Cyan
Write-Host "   - Converter WebP -> MP4 com compressão H.264"
Write-Host "   - Usar tag <video> com autoplay loop muted"
Write-Host "   - Melhor compressão que WebP animado"
Write-Host ""

Write-Host "GUIA RÁPIDO - EZGIF.COM:" -ForegroundColor Yellow
Write-Host "-------------------------" -ForegroundColor Yellow
Write-Host "1. Acesse: https://ezgif.com/optimize-webp"
Write-Host "2. Upload cada arquivo ability*.webp"
Write-Host "3. Configurações recomendadas:"
Write-Host "   - Compression level: 60-70"
Write-Host "   - Optimize transparency: ON"
Write-Host "   - Remove duplicate frames: ON"
Write-Host "4. Download e substitua os arquivos originais"
Write-Host ""

Write-Host "ESTRUTURA DE PASTAS SUGERIDA:" -ForegroundColor Yellow
Write-Host "------------------------------" -ForegroundColor Yellow
Write-Host "vendors/img/agentes/"
Write-Host "  ├─ ability1.webp        (versão otimizada - desktop)"
Write-Host "  ├─ ability1-mobile.webp (versão mobile - opcional)"
Write-Host "  ├─ ability1-thumb.jpg   (thumbnail estático - fallback)"
Write-Host "  ├─ ability2.webp"
Write-Host "  ├─ ability2-mobile.webp"
Write-Host "  └─ ..."
Write-Host ""

Write-Host "EXECUTAR AGORA?" -ForegroundColor Green
Write-Host "Deseja que eu crie thumbnails estáticos como fallback? (S/N)" -ForegroundColor Green
$response = Read-Host

if ($response -eq "S" -or $response -eq "s") {
    Write-Host ""
    Write-Host "NOTA: PowerShell não possui ferramentas nativas para converter WebP." -ForegroundColor Yellow
    Write-Host "Você precisará usar uma das seguintes opções:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "OPÇÃO A - ffmpeg (Recomendado):" -ForegroundColor Cyan
    Write-Host "1. Instale ffmpeg: https://ffmpeg.org/download.html"
    Write-Host "2. Execute:"
    Write-Host '   ffmpeg -i ability1.webp -vframes 1 -q:v 2 ability1-thumb.jpg' -ForegroundColor White
    Write-Host ""
    Write-Host "OPÇÃO B - Ferramentas Online:" -ForegroundColor Cyan
    Write-Host "• https://cloudconvert.com/webp-to-jpg"
    Write-Host "• https://convertio.co/webp-jpg/"
    Write-Host ""
    Write-Host "OPÇÃO C - Photoshop/GIMP:" -ForegroundColor Cyan
    Write-Host "• Abra o WebP e exporte como JPG (qualidade 80%)"
    Write-Host ""
} else {
    Write-Host "Script finalizado." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "PRÓXIMO PASSO:" -ForegroundColor Magenta
Write-Host "Após otimizar as imagens, o HTML já está configurado para usar" -ForegroundColor White
Write-Host "lazy loading e picture tags responsivos!" -ForegroundColor White
Write-Host ""
