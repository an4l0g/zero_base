var apartament;
var myApartament;

const actions = {
  open: ({ data }) => {
    let haveApartament = data.haveApartament;
    apartament = data.apartament;
    $("#homes").show();
    $("#action-list").html("");
    if (haveApartament[0]) {
      myApartament = haveApartament[1];
      $("#action-list").append(
        `
          <li><button class="item-description" data-value="residencia">Minha residência</button></li>
          <li><button class="item-description" data-value="interfone">Interfone</button></li>
        `
      );
    } else {
      $("#action-list").append(
        ` 
          <li> <button class="item-description" data-value="comprar"> Comprar </button> </li>
          <li><button class="item-description" data-value="interfone">Interfone</button></li> 
        `
      );
    }
  },
  residencia: () => {
    post("myApartament", myApartament);
  },
  comprar: () => {
    post("buyApartament", apartament);
  },
  interfone: () => {
    post("otherApartament", {});
  },
};

$(document).ready(() => {
  window.addEventListener("message", (event) => {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });

  document.onkeyup = (event) => {
    if (event.key == "Escape") {
      post("close", {});
    }
  };

  $(document).on("click", ".item-description", function () {
    const metodo = $(this).data("value");
    actions[metodo]();
  });
});

function post(link, value) {
  $("#homes").hide();
  $.post(`http://zero_homes/${link}`, JSON.stringify(value));
}
