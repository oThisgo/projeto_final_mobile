# 📸 Guia de Criação de Variações de Imagens - WARFRAME

## 🎯 QUAIS IMAGENS PRECISAM DE VARIAÇÕES?

Baseado na análise do projeto, apenas imagens **grandes e visíveis** precisam de variações para mobile.

---

## 🔴 PRIORIDADE ALTA - Criar Variações OBRIGATÓRIAS

### 1. **Background do Hero da Página de Personagem**
📁 Localização: `vendors/img/agentes/`

**Arquivo atual**:
- `agente1_hero_page.jpg` (3.965 KB)

**Variações a criar**:
```
agente1_hero_page.jpg           ← Desktop (manter)
agente1_hero_page-mobile.jpg    ← Mobile (criar)
agente1_hero_page-tablet.jpg    ← Tablet (criar)
```

**Como criar**:
```powershell
# Mobile (600px largura)
ffmpeg -i agente1_hero_page.jpg -vf "scale=600:-1" -q:v 3 agente1_hero_page-mobile.jpg

# Tablet (1024px largura)
ffmpeg -i agente1_hero_page.jpg -vf "scale=1024:-1" -q:v 3 agente1_hero_page-tablet.jpg
```

**Ou online**: https://squoosh.app/
- Mobile: Redimensionar para 600px largura, qualidade 70%
- Tablet: Redimensionar para 1024px largura, qualidade 75%

---

### 2. **Hero Background Principal (GIF)**
📁 Localização: `resources/img/`

**Arquivo atual**:
- `hero-fallback.gif` (635 KB)

**Variações a criar**:
```
hero-fallback.gif               ← Desktop (manter)
hero-fallback-mobile.jpg        ← Mobile (criar como imagem estática)
hero-fallback-tablet.jpg        ← Tablet (criar como imagem estática)
```

**Como criar**:
```powershell
# Extrair primeiro frame e redimensionar
ffmpeg -i hero-fallback.gif -vframes 1 -vf "scale=600:-1" -q:v 3 hero-fallback-mobile.jpg
ffmpeg -i hero-fallback.gif -vframes 1 -vf "scale=1024:-1" -q:v 3 hero-fallback-tablet.jpg
```

**IMPORTANTE**: Para mobile, usar JPG estático ao invés de GIF animado (economia de banda).

---

### 3. **Imagens da Timeline**
📁 Localização: `resources/img/`

**Arquivos atuais**:
- `timeline-2013.jpg` (728 KB) ⚠️ PESADO
- `timeline-2015.jpg` (253 KB)

**Variações a criar**:
```
timeline-2013.jpg               ← Desktop (manter)
timeline-2013-mobile.jpg        ← Mobile (criar)

timeline-2015.jpg               ← Desktop (manter)
timeline-2015-mobile.jpg        ← Mobile (criar)
```

**Como criar**:
```powershell
# Mobile (400px largura para timeline)
ffmpeg -i timeline-2013.jpg -vf "scale=400:-1" -q:v 4 timeline-2013-mobile.jpg
ffmpeg -i timeline-2015.jpg -vf "scale=400:-1" -q:v 4 timeline-2015-mobile.jpg
```

---

### 4. **Imagens dos Personagens/Agentes (PNG com transparência)**
📁 Localização: `vendors/img/agentes/`

**Arquivos atuais**:
- `agente1.png` (1.784 KB)
- `agente2.png` (1.929 KB)
- `agente3.png` (1.692 KB)
- `agente4.png` (1.834 KB)

**Variações a criar**:
```
agente1.png                     ← Desktop (manter)
agente1-mobile.png              ← Mobile (criar)

agente2.png                     ← Desktop (manter)
agente2-mobile.png              ← Mobile (criar)

agente3.png                     ← Desktop (manter)
agente3-mobile.png              ← Mobile (criar)

agente4.png                     ← Desktop (manter)
agente4-mobile.png              ← Mobile (criar)
```

**Como criar**:
```powershell
# Mobile (300px altura, mantém transparência)
ffmpeg -i agente1.png -vf "scale=-1:300" agente1-mobile.png
ffmpeg -i agente2.png -vf "scale=-1:300" agente2-mobile.png
ffmpeg -i agente3.png -vf "scale=-1:300" agente3-mobile.png
ffmpeg -i agente4.png -vf "scale=-1:300" agente4-mobile.png
```

---

## 🟡 PRIORIDADE MÉDIA - Criar se Quiser Extra Performance

### 5. **Fotos da Equipe (Página Sobre Time)**
📁 Localização: `vendors/img/equipe/`

**Arquivos atuais**:
- `william.jpg` (5.256 KB) ⚠️ PESADO
- `codigo.jpg` (3.255 KB)
- `equipe.jpg` (2.916 KB)
- `will_thiago.jpg` (2.139 KB)
- `sala_de_desenvolvimento.jpg` (1.739 KB)

**Variações a criar** (opcional):
```
william.jpg                     ← Desktop (manter)
william-mobile.jpg              ← Mobile (criar)

codigo.jpg                      ← Desktop (manter)
codigo-mobile.jpg               ← Mobile (criar)

equipe.jpg                      ← Desktop (manter)
equipe-mobile.jpg               ← Mobile (criar)

will_thiago.jpg                 ← Desktop (manter)
will_thiago-mobile.jpg          ← Mobile (criar)
```

**Como criar**:
```powershell
# Mobile (500px largura)
ffmpeg -i william.jpg -vf "scale=500:-1" -q:v 4 william-mobile.jpg
ffmpeg -i codigo.jpg -vf "scale=500:-1" -q:v 4 codigo-mobile.jpg
ffmpeg -i equipe.jpg -vf "scale=500:-1" -q:v 4 equipe-mobile.jpg
ffmpeg -i will_thiago.jpg -vf "scale=500:-1" -q:v 4 will_thiago-mobile.jpg
```

---

## 🟢 PRIORIDADE BAIXA - NÃO Precisa Criar

### ❌ Ícones Pequenos (já são leves)
- `logo.png`, `steam.png`, `playstation.png`, etc.
- **Motivo**: Já são pequenos (<100KB), não vale a pena

### ❌ Avatares dos Reviews
- `avatar-1.jpg`, `avatar-2.jpg`, etc.
- **Motivo**: Já são pequenos (~50KB), lazy loading é suficiente

### ❌ Ícones de Plataforma
- `xbox-one.png`, `nintendo.png`, `app-store.png`
- **Motivo**: Já otimizados

---

## 📋 CHECKLIST COMPLETO

### ✅ OBRIGATÓRIO (Fazer Primeiro):

**Página de Personagem**:
- [ ] `agente1_hero_page-mobile.jpg` (600px)
- [ ] `agente1_hero_page-tablet.jpg` (1024px)

**Hero Principal**:
- [ ] `hero-fallback-mobile.jpg` (600px, estático)
- [ ] `hero-fallback-tablet.jpg` (1024px, estático)

**Timeline**:
- [ ] `timeline-2013-mobile.jpg` (400px)
- [ ] `timeline-2015-mobile.jpg` (400px)

**Personagens na Index**:
- [ ] `agente1-mobile.png` (300px altura)
- [ ] `agente2-mobile.png` (300px altura)
- [ ] `agente3-mobile.png` (300px altura)
- [ ] `agente4-mobile.png` (300px altura)

### 🔶 OPCIONAL (Se Quiser Performance Extra):

**Equipe**:
- [ ] `william-mobile.jpg` (500px)
- [ ] `codigo-mobile.jpg` (500px)
- [ ] `equipe-mobile.jpg` (500px)
- [ ] `will_thiago-mobile.jpg` (500px)

---

## 🛠️ COMANDOS RÁPIDOS - CRIAR TODAS DE UMA VEZ

### Se tiver ffmpeg instalado:

```powershell
# Navegar para pasta do projeto
cd "C:\Senac\Desenvolvimento Mobile\Projeto Final\Projeto Final"

# Hero backgrounds
cd "vendors\img\agentes"
ffmpeg -i agente1_hero_page.jpg -vf "scale=600:-1" -q:v 3 agente1_hero_page-mobile.jpg
ffmpeg -i agente1_hero_page.jpg -vf "scale=1024:-1" -q:v 3 agente1_hero_page-tablet.jpg

# Personagens
ffmpeg -i agente1.png -vf "scale=-1:300" agente1-mobile.png
ffmpeg -i agente2.png -vf "scale=-1:300" agente2-mobile.png
ffmpeg -i agente3.png -vf "scale=-1:300" agente3-mobile.png
ffmpeg -i agente4.png -vf "scale=-1:300" agente4-mobile.png

# Timeline
cd "..\..\resources\img"
ffmpeg -i hero-fallback.gif -vframes 1 -vf "scale=600:-1" -q:v 3 hero-fallback-mobile.jpg
ffmpeg -i hero-fallback.gif -vframes 1 -vf "scale=1024:-1" -q:v 3 hero-fallback-tablet.jpg
ffmpeg -i timeline-2013.jpg -vf "scale=400:-1" -q:v 4 timeline-2013-mobile.jpg
ffmpeg -i timeline-2015.jpg -vf "scale=400:-1" -q:v 4 timeline-2015-mobile.jpg

# Equipe (opcional)
cd "..\..\vendors\img\equipe"
ffmpeg -i william.jpg -vf "scale=500:-1" -q:v 4 william-mobile.jpg
ffmpeg -i codigo.jpg -vf "scale=500:-1" -q:v 4 codigo-mobile.jpg
ffmpeg -i equipe.jpg -vf "scale=500:-1" -q:v 4 equipe-mobile.jpg
ffmpeg -i will_thiago.jpg -vf "scale=500:-1" -q:v 4 will_thiago-mobile.jpg
```

### Sem ffmpeg? Use ferramentas online:

**Squoosh (Google)**: https://squoosh.app/
1. Upload a imagem
2. Resize conforme tabela abaixo
3. Ajuste qualidade (70-80%)
4. Download com nome correto

**Ou EZGIF**: https://ezgif.com/resize
1. Upload imagem
2. New width conforme tabela
3. Download

---

## 📊 TABELA DE REFERÊNCIA RÁPIDA

| Arquivo Original | Variação Mobile | Tamanho Mobile | Variação Tablet | Tamanho Tablet |
|-----------------|-----------------|----------------|-----------------|----------------|
| `agente1_hero_page.jpg` | `-mobile.jpg` | 600px | `-tablet.jpg` | 1024px |
| `hero-fallback.gif` | `-mobile.jpg` | 600px | `-tablet.jpg` | 1024px |
| `timeline-2013.jpg` | `-mobile.jpg` | 400px | - | - |
| `timeline-2015.jpg` | `-mobile.jpg` | 400px | - | - |
| `agente1.png` | `-mobile.png` | 300px altura | - | - |
| `agente2.png` | `-mobile.png` | 300px altura | - | - |
| `agente3.png` | `-mobile.png` | 300px altura | - | - |
| `agente4.png` | `-mobile.png` | 300px altura | - | - |
| `william.jpg` | `-mobile.jpg` | 500px | - | - |
| `codigo.jpg` | `-mobile.jpg` | 500px | - | - |

---

## 🔧 COMO O HTML VAI USAR (Já Configurado)

O HTML já está preparado para usar automaticamente as variações que você criar:

```html
<!-- Exemplo: Hero Background -->
<picture>
    <source media="(max-width: 480px)" srcset="hero-fallback-mobile.jpg">
    <source media="(max-width: 768px)" srcset="hero-fallback-tablet.jpg">
    <img src="hero-fallback.gif" alt="Hero" loading="eager">
</picture>

<!-- Exemplo: Personagem -->
<picture>
    <source media="(max-width: 768px)" srcset="agente1-mobile.png">
    <img src="agente1.png" alt="Personagem" loading="lazy">
</picture>
```

**Se a variação não existir**: O browser usa a imagem original (desktop) como fallback.

---

## 💾 ECONOMIA DE BANDA ESPERADA

### Sem Variações:
- Mobile carrega: 3.965 KB (hero) + 1.784 KB (agente) + 635 KB (gif) = **6.384 KB**

### Com Variações:
- Mobile carrega: ~150 KB (hero) + ~80 KB (agente) + ~100 KB (gif) = **~330 KB**

**Economia: ~95% menos dados em mobile!** 🚀

---

## ⚠️ IMPORTANTE

1. **Mantenha sempre o arquivo original**: Ele é o fallback para desktop
2. **Use o sufixo `-mobile`**: O código já está configurado para isso
3. **PNG para imagens com transparência**: Agentes devem ser PNG
4. **JPG para fotos/backgrounds**: Mais leve que PNG
5. **Não precisa criar TODAS**: Comece pelas obrigatórias

---

## 🎯 RESUMO PRÁTICO

**Mínimo necessário** (4 arquivos):
1. `agente1_hero_page-mobile.jpg`
2. `hero-fallback-mobile.jpg`
3. `timeline-2013-mobile.jpg`
4. `timeline-2015-mobile.jpg`

**Recomendado** (+8 arquivos):
5-8. `agente1-mobile.png` até `agente4-mobile.png`
9-12. Tablets: `-tablet.jpg` para heroes

**Extra performance** (+4 arquivos):
13-16. Fotos da equipe: `*-mobile.jpg`

**TOTAL**: 8-16 arquivos novos para performance máxima.

---

**Última atualização**: Novembro 2025
**Versão**: 1.0
