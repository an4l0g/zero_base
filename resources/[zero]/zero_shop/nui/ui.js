var _list;
var method;
let carrinho = {};
let item_values = {};

const actions = {
  open: ({ list, shopMode, shopName, shopIdentity }) => {
    _list = list;
    $("#title-shop").html(`
      <span>[ZERO]</span> ${shopName}
    `);
    $("#username").text(shopIdentity);
    $("departamento").css("display", "flex");
    shopType(shopMode);
  },
  total_shop: () => {
    let value = 0;
    $.each(item_values, function (index, data) {
      if (carrinho[index]) {
        var total = carrinho[index] * data;
        value += total;
      }
    });
    $(".cart-content span").html(formatarNumero(value));
  },
};

$(document).ready(function () {
  window.addEventListener("message", function (data) {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);

    document.onkeyup = function (data) {
      if (data.which == 27) {
        closeNui();
      }
    };

    $(document).on("change", ".input-value", function () {
      let item = this.dataset.item;
      carrinho[item] = parseInt($(this).val());
      actions["total_shop"]();
    });
  });
});

function shopType(mode) {
  $(".buy-tab, .sell-tab").hide();
  if (mode === "buy") {
    changeMode("buy");
    $(".buy-tab").show();
  } else if (mode === "sell") {
    changeMode("sell");
    $(".sell-tab").show();
  } else if (mode === "all") {
    changeMode("buy");
    $(".buy-tab, .sell-tab").show();
  }
}

const generateItemCard = (index, data, priceType) => {
  if (data.price[priceType] > 0) {
    return `
      <li class="item-card">
        <div class="wrap-image">
          <img src="http://189.0.88.222/zero_inventory/${data.index}.png" />
          <span>${data.name}</span>
        </div>
        <div class="insert-amount">
          <input
            type="text"
            class="input-value"
            data-item="${index}"
            placeholder="Quantidade"
            value=""
          />
        </div>
        <div class="item-value">${formatarNumero(data.price[priceType])}</div>
      </li>
    `;
  } else {
    return "";
  }
};

const changeMode = (mode) => {
  method = mode;
  $(".item-content").html("");
  $(".cta-shop").removeClass("active");
  $(".cart-content span").html("R$0,00");
  item_values = {};
  $.each(_list, function (index, data) {
    if (mode == "buy") {
      item_values[index] = data.price.buy;
      $("#cta-buy").addClass("active");
      $(".item-content").append(generateItemCard(index, data, "buy"));
    } else if (mode == "sell") {
      item_values[index] = data.price.sell;
      $("#cta-sell").addClass("active");
      $(".item-content").append(generateItemCard(index, data, "sell"));
    }
  });
};

const payment = () => {
  $.post(
    "https://zero_shop/buy",
    JSON.stringify({ cart: carrinho, method: method })
  );
  closeNui();
};

const formatarNumero = (n) => {
  n = parseFloat(n).toFixed(2);

  return parseFloat(n).toLocaleString("pt-BR", {
    style: "currency",
    currency: "BRL",
  });
};

function closeNui() {
  _list = null;
  method = null;
  carrinho = {};
  item_values = {};
  $("departamento").css("display", "none");
  $.post("https://zero_shop/close");
}
