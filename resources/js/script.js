$(function(){

    // Auto-play de carrossel: avança automaticamente pelos cards
    function addAutoPlay(container, cardSelector) {
        if (!container) return;
        
        let isAutoPlaying = true;
        let autoPlayInterval;
        let currentIndex = 0;
        
        const startAutoPlay = () => {
            if (!isAutoPlaying) return;
            
            autoPlayInterval = setInterval(() => {
                if (!isAutoPlaying) {
                    clearInterval(autoPlayInterval);
                    return;
                }
                
                const cards = container.querySelectorAll(cardSelector);
                if (cards.length === 0) return;
                
                const containerWidth = container.offsetWidth;
                const maxScroll = container.scrollWidth - containerWidth;
                
                // Avança para o próximo card
                currentIndex++;
                
                // Se passou do último card, volta pro início
                if (currentIndex >= cards.length) {
                    currentIndex = 0;
                }
                
                // Calcula posição baseada no índice
                let nextScroll = currentIndex * containerWidth * 0.9;
                
                // Garante que não ultrapasse o máximo
                if (nextScroll > maxScroll) {
                    nextScroll = 0;
                    currentIndex = 0;
                }
                
                container.scrollTo({
                    left: nextScroll,
                    behavior: 'smooth'
                });
                
            }, 3000); // Troca a cada 3 segundos
        };
        
        const stopAutoPlay = () => {
            isAutoPlaying = false;
            if (autoPlayInterval) {
                clearInterval(autoPlayInterval);
            }
        };
        
        // Para quando usuário interagir
        container.addEventListener('touchstart', stopAutoPlay, { once: true });
        container.addEventListener('mousedown', stopAutoPlay, { once: true });
        container.addEventListener('wheel', stopAutoPlay, { once: true });
        
        // Inicia após 2 segundos
        setTimeout(startAutoPlay, 2000);
    }

    // Linha do tempo: carrossel arrastável no mobile
    const timeline = document.querySelector('.timeline-container');
    if (timeline && window.matchMedia('(max-width: 700px)').matches) {
        let isDown = false;
        let startX, scrollLeft;

        // Adiciona auto-play
        addAutoPlay(timeline, '.timeline-event');

        timeline.addEventListener('mousedown', (e) => {
            isDown = true;
            timeline.classList.add('dragging');
            startX = e.pageX - timeline.offsetLeft;
            scrollLeft = timeline.scrollLeft;
        });
        timeline.addEventListener('mouseleave', () => {
            isDown = false;
            timeline.classList.remove('dragging');
        });
        timeline.addEventListener('mouseup', () => {
            isDown = false;
            timeline.classList.remove('dragging');
        });
        timeline.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - timeline.offsetLeft;
            const walk = (x - startX) * 1.2;
            timeline.scrollLeft = scrollLeft - walk;
        });
        
        // Touch events para mobile
        timeline.addEventListener('touchstart', (e) => {
            isDown = true;
            startX = e.touches[0].pageX - timeline.offsetLeft;
            scrollLeft = timeline.scrollLeft;
        });
        timeline.addEventListener('touchend', () => {
            isDown = false;
        });
        timeline.addEventListener('touchmove', (e) => {
            if (!isDown) return;
            const x = e.touches[0].pageX - timeline.offsetLeft;
            const walk = (x - startX) * 1.2;
            timeline.scrollLeft = scrollLeft - walk;
        });
    }

    // Reviews: adiciona auto-play no mobile
    const reviewsContainer = document.querySelector('.reviews-container');
    if (reviewsContainer && window.matchMedia('(max-width: 700px)').matches) {
        addAutoPlay(reviewsContainer, '.review-card');
    }

    // Abas de requisitos do sistema
    const tabs = document.querySelectorAll('.tab');
    const minimumSection = document.querySelector('.system-minimum');
    const recommendedSection = document.querySelector('.system-recommended');

    if (tabs.length > 0 && minimumSection && recommendedSection) {
        // Mostra a aba de mínimos por padrão
        minimumSection.classList.add('active');

        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // Remove active de todas as abas
                tabs.forEach(t => {
                    t.classList.remove('active');
                    t.setAttribute('aria-selected', 'false');
                });

                // Adiciona active na aba clicada
                this.classList.add('active');
                this.setAttribute('aria-selected', 'true');

                // Mostra o conteúdo correspondente
                const target = this.getAttribute('data-target');
                
                minimumSection.classList.remove('active');
                recommendedSection.classList.remove('active');

                if (target === 'minimum') {
                    minimumSection.classList.add('active');
                } else if (target === 'recommended') {
                    recommendedSection.classList.add('active');
                }
            });
        });
    }

    // Formulário de comunidade
    const communityForm = document.getElementById('communityForm');
    if (communityForm) {
        communityForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const fullName = document.getElementById('fullName').value.trim();
            const nickname = document.getElementById('nickname').value.trim();
            const email = document.getElementById('email').value.trim();
            const platform = document.getElementById('platform').value;
            const age = document.getElementById('age').value;
            const country = document.getElementById('country').value.trim();
            const modeSelected = document.querySelector('input[name="mode"]:checked');
            
            if (!fullName || !nickname || !email || !platform || !age || !country || !modeSelected) {
                alert('Please fill in all required fields.');
                return;
            }
            
            if (age < 13) {
                alert('You must be at least 13 years old to join.');
                return;
            }
            
            localStorage.setItem('communitySignup', JSON.stringify({ 
                fullName, 
                nickname, 
                email, 
                platform, 
                age, 
                country, 
                mode: modeSelected.value, 
                timestamp: new Date().toISOString() 
            }));
            
            window.location.href = 'thank-you.html';
        });
    }
});
