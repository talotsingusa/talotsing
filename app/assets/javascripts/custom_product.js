// document.documentElement.setAttribute("lang", "en");
// document.documentElement.removeAttribute("class");

// axe.run(function (err, results) {
//     console.log(results.violations);
// });
$(document).ready(function () {
    $(".size button").mouseover(function () {
        var allButtons = document.querySelectorAll('.size button');
        for (var i = 0; i < allButtons.length; i++) {
            if (allButtons[i].id === this.id) {
                allButtons[i].className = 'btn btn-primary';
                var showMe = document.getElementsByClassName(allButtons[i].id);
                showMe[0].style.display = 'block';
            } else {
                var showMe = document.getElementsByClassName(allButtons[i].id);
                showMe[0].style.display = 'none';
                allButtons[i].className = 'btn btn-default';
            }

        }
    });
    $(document).ready(function () {
        $('#carousel-thumb-hover li')[0].click();
    });
    $('#carousel-thumb-hover li').mouseover(function () {
        this.click();
    });

    var evt = new Event(),
        m = new Magnifier(evt);

    $('.zoome').mouseover(function () {
        $('.magnifier-preview').show();
        m.attach({
            thumb: '.zoome',
            large: this.src,
            largeWrapper: 'preview',
            zoom: 5
        });
    });

    $('.sizecheckbox span').click(function() {
        var allspan = document.querySelectorAll('.sizecheckbox span');
        for(var i = 0; i < allspan.length; i++) {
            allspan[i].className = '';
        }
        $(this).addClass('hovers');
        $('#sizecheckboxvalue').val($(this).attr("data-title"));
    });
    $('.colorcheckbox span').click(function() {
        var allspan = document.querySelectorAll('.colorcheckbox span');
        for(var i = 0; i < allspan.length; i++) {
            allspan[i].className = '';
        }
        $(this).addClass('hovers');
        $('#colorcheckbox').val($(this).attr("data-title"));
    });
    $('.shippingcheckbox span').click(function() {
        var allspan = document.querySelectorAll('.shippingcheckbox span');
        for(var i = 0; i < allspan.length; i++) {
            allspan[i].className = '';
        }
        $(this).addClass('hovers');
        $('#shippingcheckbox').val($(this).attr("data-title"));
    });
});