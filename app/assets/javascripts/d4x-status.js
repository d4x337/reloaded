$(document).ready(function(){
    $('body').on('change', '.theme-switch input:radio', function () {
        var status_id = $(this).val();
        $.ajax({
            url: "set-status",
            cache: false,
            type: 'POST',
            beforeSend: function(xhr){
                // IMPORTANTO FOR APPSEC AGAINST CSRF ATTACKS, Add this header to ALL Ajax Requests!!!!!!!!!!!!!! :)
                xhr.setRequestHeader('X-CSRF-Token',$('meta[name="csrf-token"]').attr('content'))
            },
            data: {
                background_id:theme
            },
            dataType: "json",

            success: function(data) {

            }
        });
        $('body').attr('data-sa-theme', theme);
    });
});
