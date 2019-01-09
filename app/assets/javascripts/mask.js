window.onload = function () {
    Array.from(document.getElementsByClassName('phone-input')).forEach(function (element) {
        new IMask(element, {
            mask: '+{38}(000)000-00-00',
            lazy: false,
        });
    });
};

function unmaskPhone() {
    Array.from(document.getElementsByClassName('phone-input')).forEach(function (element) {
        element.value = new IMask(
            element, {mask: '+{38}(000)000-00-00'}
        ).unmaskedValue;
    });
}
