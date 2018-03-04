$( document ).ready(function() {
  $(".alert").fadeTo(3000, 0).slideUp(700, function(){
      $(this).remove();
  });
}, 5000);