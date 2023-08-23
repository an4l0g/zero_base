function button(key) {
  $.post("http://zero_radio/ButtonClick", JSON.stringify(key));
}

$(function () {
  let container = $("#actionmenu");
  window.addEventListener("message", function (event) {
    let item = event.data;

    if (item.showmenu) {
      //let radios = item.radios.sort((a,b) => (a.name > b.name) ? 1: -1);
      $("#radios").html(
        `${item.radios
          .map(
            (data) =>
              `<button class="menuoption" onclick="button('connect-${data.radio}')">${data.name}</button>`
          )
          .join("")}`
      );
      container.fadeIn(500);
    } else {
      container.fadeOut(500);
    }
  });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      if (container.is(":visible")) {
        button("close");
      }
    }
  };
});
