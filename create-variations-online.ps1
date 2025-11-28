# Script Simplificado - Criar Variações SEM FFMPEG
# Usa ferramentas online (Squoosh.app)

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  CRIADOR DE VARIAÇÕES - SEM FFMPEG" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Este script vai gerar um guia passo a passo para você" -ForegroundColor Yellow
Write-Host "criar as variações de imagens usando Squoosh.app" -ForegroundColor Yellow
Write-Host ""

# Analisar quais arquivos existem
$basePath = Get-Location

Write-Host "Analisando arquivos existentes..." -ForegroundColor Gray
Write-Host ""

$tasks = @()

# 1. Hero backgrounds
if (Test-Path "vendors\img\agentes\agente1_hero_page.jpg") {
    $tasks += @{
        Original = "vendors\img\agentes\agente1_hero_page.jpg"
        Mobile = "vendors\img\agentes\agente1_hero_page-mobile.jpg"
        Tablet = "vendors\img\agentes\agente1_hero_page-tablet.jpg"
        MobileSize = "600px"
        TabletSize = "1024px"
        Priority = "ALTA"
    }
}

if (Test-Path "resources\img\hero-fallback.gif") {
    $tasks += @{
        Original = "resources\img\hero-fallback.gif"
        Mobile = "resources\img\hero-fallback-mobile.jpg"
        Tablet = "resources\img\hero-fallback-tablet.jpg"
        MobileSize = "600px"
        TabletSize = "1024px"
        Priority = "ALTA"
        Note = "Extrair frame estatico para JPG"
    }
}

# 2. Timeline
if (Test-Path "resources\img\timeline-2013.jpg") {
    $tasks += @{
        Original = "resources\img\timeline-2013.jpg"
        Mobile = "resources\img\timeline-2013-mobile.jpg"
        MobileSize = "400px"
        Priority = "ALTA"
    }
}

if (Test-Path "resources\img\timeline-2015.jpg") {
    $tasks += @{
        Original = "resources\img\timeline-2015.jpg"
        Mobile = "resources\img\timeline-2015-mobile.jpg"
        MobileSize = "400px"
        Priority = "ALTA"
    }
}

# 3. Personagens
for ($i = 1; $i -le 4; $i++) {
    if (Test-Path "vendors\img\agentes\agente$i.png") {
        $tasks += @{
            Original = "vendors\img\agentes\agente$i.png"
            Mobile = "vendors\img\agentes\agente$i-mobile.png"
            MobileSize = "300px (altura)"
            Priority = "ALTA"
        }
    }
}

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  ARQUIVOS ENCONTRADOS: $($tasks.Count)" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

$counter = 1
foreach ($task in $tasks) {
    Write-Host "[$counter/$($tasks.Count)] $($task.Priority) - $(Split-Path $task.Original -Leaf)" -ForegroundColor Yellow
    Write-Host "   Original: $($task.Original)" -ForegroundColor Gray
    Write-Host "   Mobile:   $($task.Mobile) ($($task.MobileSize))" -ForegroundColor Cyan
    if ($task.Tablet) {
        Write-Host "   Tablet:   $($task.Tablet) ($($task.TabletSize))" -ForegroundColor Cyan
    }
    if ($task.Note) {
        Write-Host "   $($task.Note)" -ForegroundColor Magenta
    }
    Write-Host ""
    $counter++
}

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  PASSO A PASSO - SQUOOSH.APP" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "1️⃣  ABRIR SQUOOSH" -ForegroundColor Green
Write-Host "   * Acesse: https://squoosh.app/" -ForegroundColor White
Write-Host "   * Deixe a aba aberta para usar multiplas vezes" -ForegroundColor Gray
Write-Host ""

Write-Host "2️⃣  PARA CADA ARQUIVO ACIMA:" -ForegroundColor Green
Write-Host ""

Write-Host "   A. Upload da Imagem:" -ForegroundColor Yellow
Write-Host "      * Arraste o arquivo para Squoosh.app" -ForegroundColor White
Write-Host "      * OU clique e selecione" -ForegroundColor White
Write-Host ""

Write-Host "   B. Redimensionar:" -ForegroundColor Yellow
Write-Host "      * No painel direito, procure 'Resize'" -ForegroundColor White
Write-Host "      * Ative a opcao 'Resize'" -ForegroundColor White
Write-Host "      * Em 'Width', digite o tamanho da coluna 'MobileSize' acima" -ForegroundColor White
Write-Host "      * Exemplo: 600 para hero, 400 para timeline, 300 para agentes" -ForegroundColor White
Write-Host "      * Mantenha 'Maintain aspect ratio' MARCADO" -ForegroundColor Cyan
Write-Host ""

Write-Host "   C. Ajustar Qualidade:" -ForegroundColor Yellow
Write-Host "      * No painel direito, encontre 'Quality'" -ForegroundColor White
Write-Host "      * Ajuste para 70-80%" -ForegroundColor White
Write-Host "      * Para PNG (agentes), use 'MozJPEG' ou mantenha PNG" -ForegroundColor White
Write-Host ""

Write-Host "   D. Download:" -ForegroundColor Yellow
Write-Host "      * Clique no botao de download (canto inferior direito)" -ForegroundColor White
Write-Host "      * Renomeie o arquivo para o nome da coluna 'Mobile' acima" -ForegroundColor White
Write-Host "      * Exemplo: agente1_hero_page.jpg -> agente1_hero_page-mobile.jpg" -ForegroundColor Cyan
Write-Host ""

Write-Host "   E. Colocar na Pasta Correta:" -ForegroundColor Yellow
Write-Host "      * Coloque o arquivo na mesma pasta do original" -ForegroundColor White
Write-Host "      * Exemplo: se original esta em vendors\img\agentes\" -ForegroundColor Gray
Write-Host "      *          coloque o -mobile.jpg tambem la" -ForegroundColor Gray
Write-Host ""

Write-Host "3️⃣  REPETIR para todos os $($tasks.Count) arquivos" -ForegroundColor Green
Write-Host ""

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  ATALHOS PARA AGILIZAR" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "* Abra varias abas do Squoosh (uma para cada imagem)" -ForegroundColor White
Write-Host "* Configure todas e depois faca download em sequencia" -ForegroundColor White
Write-Host "* Para GIF: marque 'Extract 1 frame' antes de resize" -ForegroundColor White
Write-Host ""

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  CHECKLIST" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

foreach ($task in $tasks) {
    Write-Host "[ ] $(Split-Path $task.Mobile -Leaf)" -ForegroundColor Gray
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  APOS CRIAR TODAS AS VARIACOES" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "1. Abra o site no navegador" -ForegroundColor White
Write-Host "2. Pressione F12 (DevTools)" -ForegroundColor White
Write-Host "3. Ative modo mobile: Ctrl+Shift+M" -ForegroundColor White
Write-Host "4. Recarregue: Ctrl+Shift+R" -ForegroundColor White
Write-Host "5. Va na aba 'Network'" -ForegroundColor White
Write-Host "6. Verifique que esta carregando os arquivos -mobile" -ForegroundColor White
Write-Host ""

Write-Host "=========================================" -ForegroundColor Green
Write-Host "  ALTERNATIVA RAPIDA - BULK RESIZE" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Se preferir processar multiplas imagens de uma vez:" -ForegroundColor Yellow
Write-Host ""
Write-Host "* https://bulkresizephotos.com/" -ForegroundColor Cyan
Write-Host "  - Upload multiplas imagens" -ForegroundColor White
Write-Host "  - Define largura (600, 400, 300)" -ForegroundColor White
Write-Host "  - Download todas de uma vez" -ForegroundColor White
Write-Host "  - Renomeie manualmente depois" -ForegroundColor Gray
Write-Host ""

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pronto para comecar? Bom trabalho!" -ForegroundColor Green
Write-Host ""
Write-Host "Dica: Comece pelos 4 primeiros (prioridade ALTA)" -ForegroundColor Yellow
Write-Host "      e teste antes de fazer os outros!" -ForegroundColor Yellow
Write-Host ""

# Oferecer abrir Squoosh
Write-Host "Deseja abrir Squoosh.app no navegador agora? (S/N)" -ForegroundColor Cyan
$response = Read-Host

if ($response -eq "S" -or $response -eq "s") {
    Start-Process "https://squoosh.app/"
    Write-Host ""
    Write-Host "Squoosh.app aberto no navegador!" -ForegroundColor Green
    Write-Host ""
}

Write-Host "Script finalizado. Boa sorte!" -ForegroundColor Green
Write-Host ""
