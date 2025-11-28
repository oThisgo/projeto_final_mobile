# Script para criar todas as variações de imagens automaticamente
# Requer ffmpeg instalado: https://ffmpeg.org/download.html

Write-Host "=== Gerador de Variações de Imagens - WARFRAME ===" -ForegroundColor Cyan
Write-Host ""

# Verificar se ffmpeg está instalado
$ffmpegExists = Get-Command ffmpeg -ErrorAction SilentlyContinue
if (-not $ffmpegExists) {
    Write-Host "ERRO: ffmpeg não encontrado!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Por favor, instale o ffmpeg:" -ForegroundColor Yellow
    Write-Host "1. Baixe: https://ffmpeg.org/download.html" -ForegroundColor White
    Write-Host "2. Extraia para C:\ffmpeg" -ForegroundColor White
    Write-Host "3. Adicione C:\ffmpeg\bin ao PATH do sistema" -ForegroundColor White
    Write-Host ""
    Write-Host "Ou use as ferramentas online:" -ForegroundColor Yellow
    Write-Host "- https://squoosh.app/" -ForegroundColor White
    Write-Host "- https://ezgif.com/resize" -ForegroundColor White
    Write-Host ""
    exit
}

Write-Host "✓ ffmpeg encontrado!" -ForegroundColor Green
Write-Host ""

$basePath = Get-Location
$errors = @()
$created = @()

# Função para criar variação
function Create-ImageVariation {
    param(
        [string]$sourcePath,
        [string]$outputPath,
        [string]$scale,
        [string]$quality = "3"
    )
    
    if (Test-Path $sourcePath) {
        Write-Host "Processando: $sourcePath" -ForegroundColor Yellow
        $result = ffmpeg -i $sourcePath -vf "scale=$scale" -q:v $quality $outputPath -y 2>&1
        
        if (Test-Path $outputPath) {
            $size = [math]::Round((Get-Item $outputPath).Length / 1KB, 2)
            Write-Host "  ✓ Criado: $outputPath ($size KB)" -ForegroundColor Green
            $script:created += $outputPath
        } else {
            Write-Host "  ✗ Erro ao criar: $outputPath" -ForegroundColor Red
            $script:errors += $outputPath
        }
    } else {
        Write-Host "  ⚠ Arquivo não encontrado: $sourcePath" -ForegroundColor Yellow
        $script:errors += $sourcePath
    }
}

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "CRIANDO VARIAÇÕES OBRIGATÓRIAS" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

# 1. Hero Background da Página de Personagem
Write-Host "1. Hero Background do Personagem..." -ForegroundColor Magenta
$source = "vendors\img\agentes\agente1_hero_page.jpg"
Create-ImageVariation $source "vendors\img\agentes\agente1_hero_page-mobile.jpg" "600:-1" "3"
Create-ImageVariation $source "vendors\img\agentes\agente1_hero_page-tablet.jpg" "1024:-1" "3"
Write-Host ""

# 2. Hero Background Principal (GIF -> JPG estático para mobile)
Write-Host "2. Hero Background Principal (GIF)..." -ForegroundColor Magenta
$source = "resources\img\hero-fallback.gif"
if (Test-Path $source) {
    Write-Host "Processando: $source" -ForegroundColor Yellow
    # Extrair primeiro frame
    ffmpeg -i $source -vframes 1 -vf "scale=600:-1" -q:v 3 "resources\img\hero-fallback-mobile.jpg" -y 2>&1 | Out-Null
    ffmpeg -i $source -vframes 1 -vf "scale=1024:-1" -q:v 3 "resources\img\hero-fallback-tablet.jpg" -y 2>&1 | Out-Null
    
    if (Test-Path "resources\img\hero-fallback-mobile.jpg") {
        $size = [math]::Round((Get-Item "resources\img\hero-fallback-mobile.jpg").Length / 1KB, 2)
        Write-Host "  ✓ Criado: hero-fallback-mobile.jpg ($size KB)" -ForegroundColor Green
        $script:created += "hero-fallback-mobile.jpg"
    }
    if (Test-Path "resources\img\hero-fallback-tablet.jpg") {
        $size = [math]::Round((Get-Item "resources\img\hero-fallback-tablet.jpg").Length / 1KB, 2)
        Write-Host "  ✓ Criado: hero-fallback-tablet.jpg ($size KB)" -ForegroundColor Green
        $script:created += "hero-fallback-tablet.jpg"
    }
}
Write-Host ""

# 3. Timeline
Write-Host "3. Imagens da Timeline..." -ForegroundColor Magenta
Create-ImageVariation "resources\img\timeline-2013.jpg" "resources\img\timeline-2013-mobile.jpg" "400:-1" "4"
Create-ImageVariation "resources\img\timeline-2015.jpg" "resources\img\timeline-2015-mobile.jpg" "400:-1" "4"
Write-Host ""

# 4. Personagens/Agentes
Write-Host "4. Personagens (PNG com transparência)..." -ForegroundColor Magenta
for ($i = 1; $i -le 4; $i++) {
    $source = "vendors\img\agentes\agente$i.png"
    $output = "vendors\img\agentes\agente$i-mobile.png"
    Create-ImageVariation $source $output "-1:300" "3"
}
Write-Host ""

# Perguntar sobre variações opcionais
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Deseja criar as variações OPCIONAIS da equipe?" -ForegroundColor Yellow
Write-Host "(Fotos grandes da página 'Sobre o Time')" -ForegroundColor Gray
Write-Host ""
$response = Read-Host "Criar variações da equipe? (S/N)"

if ($response -eq "S" -or $response -eq "s") {
    Write-Host ""
    Write-Host "===========================================" -ForegroundColor Cyan
    Write-Host "CRIANDO VARIAÇÕES OPCIONAIS - EQUIPE" -ForegroundColor Cyan
    Write-Host "===========================================" -ForegroundColor Cyan
    Write-Host ""
    
    $teamImages = @("william.jpg", "codigo.jpg", "equipe.jpg", "will_thiago.jpg")
    foreach ($img in $teamImages) {
        $source = "vendors\img\equipe\$img"
        $output = "vendors\img\equipe\$($img.Replace('.jpg', '-mobile.jpg'))"
        Create-ImageVariation $source $output "500:-1" "4"
    }
}

Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "RESUMO FINAL" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Arquivos criados: $($created.Count)" -ForegroundColor Green
if ($created.Count -gt 0) {
    foreach ($file in $created) {
        Write-Host "  ✓ $file" -ForegroundColor Gray
    }
}

Write-Host ""
if ($errors.Count -gt 0) {
    Write-Host "Erros encontrados: $($errors.Count)" -ForegroundColor Red
    foreach ($file in $errors) {
        Write-Host "  ✗ $file" -ForegroundColor Gray
    }
} else {
    Write-Host "✓ Nenhum erro!" -ForegroundColor Green
}

Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "PRÓXIMOS PASSOS:" -ForegroundColor Yellow
Write-Host "1. Verifique os arquivos criados nas pastas" -ForegroundColor White
Write-Host "2. Teste o site no navegador" -ForegroundColor White
Write-Host "3. Abra o DevTools (F12) > Network para ver a diferença" -ForegroundColor White
Write-Host "4. Em mobile, deve carregar as versões -mobile.jpg" -ForegroundColor White
Write-Host ""
Write-Host "Para testar mobile no Chrome:" -ForegroundColor Yellow
Write-Host "F12 > Toggle Device Toolbar (Ctrl+Shift+M)" -ForegroundColor White
Write-Host ""
Write-Host "Script finalizado!" -ForegroundColor Green
Write-Host ""
