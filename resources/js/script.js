$(function(){

    // Accordion da timeline (garante execução após DOM pronto)
    // Accordion removido: timeline sempre aberta

        // Linha do tempo: carrossel arrastável no mobile
        const timeline = document.querySelector('.timeline-container');
        if (timeline && window.matchMedia('(max-width: 700px)').matches) {
            let isDown = false;
            let startX, scrollLeft;

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
                const walk = (x - startX) * 1.2; // scroll speed
                timeline.scrollLeft = scrollLeft - walk;
            });
            // Touch events
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

    const $icon = $('.js--mobile-nav-icon');
    const $nav = $('.js--main-nav');

    $icon.on('click', function(){
        $nav.slideToggle(200);

    const expanded = $(this).attr('aria-expanded') === 'true';
        $(this).attr('aria-expanded', (!expanded).toString());

        // Alterna o ícone (Ionicons)
    const $i = $(this).find('ion-icon');
        if ($i.length){
            $i.attr('name', expanded ? 'menu-outline' : 'close-outline');
        }
    });

    // Ao redimensionar para desktop, remove estilos inline para voltar ao CSS
    $(globalThis).on('resize', function(){
        if (globalThis.innerWidth > 790){
            $nav.removeAttr('style');
            $icon.attr('aria-expanded', 'false');
            const $i = $icon.find('ion-icon');
            if ($i.length){
                $i.attr('name', 'menu-outline');
            }
        }
    });
});