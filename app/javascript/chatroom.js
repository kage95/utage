$(window).on("scroll", function() {
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();
    footerHeight = $("#footer").innerHeight();
    if ( scrollHeight - scrollPosition  <= footerHeight ) {
      $("#message-form").css({
        "position":"absolute",
        "bottom": footerHeight,
        "left" : "50%",
        "transform" : "translateX(-50%)"
      });
    } else {
      $("#message-form").css({
        "position":"fixed",
        "bottom": "0px",
        "left" : "50%",
        "transform" : "translateX(-50%)"
      });
    }
  });