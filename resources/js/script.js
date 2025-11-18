$(function(){
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