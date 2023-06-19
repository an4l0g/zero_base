let mostrando = 0;
let dataPart = 12;
let partId = null;
let oldPart = null;

// | Color List do FiveM [1]
var colorList = [
  "#1C1F21",
  "#272A2C",
  "#312E2C",
  "#35261C",
  "#4B321F",
  "#5C3B24",
  "#6D4C35",
  "#6B503B",
  "#765C45",
  "#7F684E",
  "#99815D",
  "#A79369",
  "#AF9C70",
  "#BBA063",
  "#D6B97B",
  "#DAC38E",
  "#9F7F59",
  "#845039",
  "#682B1F",
  "#61120C",
  "#640F0A",
  "#7C140F",
  "#A02E19",
  "#B64B28",
  "#A2502F",
  "#AA4E2B",
  "#626262",
  "#808080",
  "#AAAAAA",
  "#C5C5C5",
  "#463955",
  "#5A3F6B",
  "#763C76",
  "#ED74E3",
  "#EB4B93",
  "#F299BC",
  "#04959E",
  "#025F86",
  "#023974",
  "#3FA16A",
  "#217C61",
  "#185C55",
  "#B6C034",
  "#70A90B",
  "#439D13",
  "#DCB857",
  "#E5B103",
  "#E69102",
  "#F28831",
  "#FB8057",
  "#E28B58",
  "#D1593C",
  "#CE3120",
  "#AD0903",
  "#880302",
  "#1F1814",
  "#291F19",
  "#2E221B",
  "#37291E",
  "#2E2218",
  "#231B15",
  "#020202",
  "#706C66",
  "#9D7A50",
];

$(document).ready(function () {
  document.onkeydown = function (data) {
    if (data.keyCode == 27) {
      $("#container").fadeOut();
      $("#cores").slideUp(0);
      $("#totalDireita").html("0");
      $.post("http://nyo_barbershop/reset", JSON.stringify({}));
    }
  };

  window.addEventListener("message", function (event) {
    let item = event.data;

    if (item.action == "setPrice") {
      if (item.typeaction == "add") {
        $("#totalDireita").html(item.price);
      }
      if (item.typeaction == "remove") {
        $("#totalDireita").html(item.price);
      }
    }

    if (item.openBarberShop) {
      $("#container").fadeIn();
      dataPart = item.dataPart;
      oldPart = item.oldCustom;
      prefix = item.prefix;
      $("#totalDireita").html(0);

      if (prefix == "M") {
        $("#menu")
          .html(`<div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921801968418826/40720.png);" onclick="selectPart(this)" data-idpart="12"><div class="tooltip">Cabelo</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921803531976754/82696.png);" onclick="selectPart(this)" data-idpart="1"><div class="tooltip">Barba</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921809899716678/011d76c670bb2e9b3af10e4aa9efddc6.png);" onclick="selectPart(this)" data-idpart="4"><div class="tooltip">Maquiagem</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921800713666600/26441.png);" onclick="selectPart(this)" data-idpart="8"><div class="tooltip">Batom</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805923541954461717/31607.png);" onclick="selectPart(this)" data-idpart="2"><div class="tooltip">Sobrancelha</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805923179964137482/1746309-200.png);" onclick="selectPart(this)" data-idpart="3"><div class="tooltip">Envelhecimento</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921805147570217/306571-200.png);" onclick="selectPart(this)" data-idpart="5"><div class="tooltip">Blush</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805920128708509727/icon_tratamento_fios.png);" onclick="selectPart(this)" data-idpart="6"><div class="tooltip">Rugas</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805920130579038258/icon.png);" onclick="selectPart(this)" data-idpart="9"><div class="tooltip">Sardas</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921807143010354/chest_male_icon_143248.png);" onclick="selectPart(this)" data-idpart="10"><div class="tooltip">Pelo no peito</div></div>
                    `);
      } else {
        $("#menu")
          .html(`<div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921801968418826/40720.png);" onclick="selectPart(this)" data-idpart="12"><div class="tooltip">Cabelo</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921809899716678/011d76c670bb2e9b3af10e4aa9efddc6.png);" onclick="selectPart(this)" data-idpart="4"><div class="tooltip">Maquiagem</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921800713666600/26441.png);" onclick="selectPart(this)" data-idpart="8"><div class="tooltip">Batom</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805923541954461717/31607.png);" onclick="selectPart(this)" data-idpart="2"><div class="tooltip">Sobrancelha</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805923179964137482/1746309-200.png);" onclick="selectPart(this)" data-idpart="3"><div class="tooltip">Envelhecimento</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805921805147570217/306571-200.png);" onclick="selectPart(this)" data-idpart="5"><div class="tooltip">Blush</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805920128708509727/icon_tratamento_fios.png);" onclick="selectPart(this)" data-idpart="6"><div class="tooltip">Rugas</div></div>
                <div class="menuType" style="background-image: url(https://cdn.discordapp.com/attachments/746851286422519928/805920130579038258/icon.png);" onclick="selectPart(this)" data-idpart="9"><div class="tooltip">Sardas</div></div>
                    `);
      }
      $.post(
        "http://nyo_barbershop/updateGui",
        JSON.stringify({ part: dataPart })
      );
    }

    if (item.updateBarberShop) {
      $("#primaria").html("");
      $("#secundaria").html("");
      var corPrim = false;
      var corSec = false;

      if (dataPart == 1 || dataPart == 2 || dataPart == 5 || dataPart == 8) {
        //|| dataPart == 10
        corPrim = true;
      } else if (dataPart == 12) {
        corPrim = true;
        corSec = true;
      } else {
        $("#cores").slideUp(200);
      }

      if (corPrim || corSec) {
        if (mostrando == 0) {
          $("#cores").slideDown(200);
        }
        if (corPrim) {
          for (var i in colorList) {
            $("#primaria").append(
              `<div class="cor" style="background: ${colorList[i]};" onClick="changeColor('${i}','1')"></div>`
            );
          }
        }

        if (corSec) {
          for (var i in colorList) {
            $("#secundaria").append(
              `<div class="cor" style="background: ${colorList[i]};" onClick="changeColor('${i}','2')"></div>`
            );
          }
        }
      }

      // | Alterar o Ip abaixo para o das suas imagens [1]
      $("#listagem").html("");
      for (var i = 0; i <= item.drawable; i++) {
        $("#listagem").append(`
                    <div class="lista" data-id="${i}" onclick="select(this)" id="${dataPart}${i}" style="background-image: url('http://189.127.164.126/barber/${dataPart}/${item.prefix}/${i}.jpg'); background-size: 160px 160px;">
                        <div class="valorItem">R$500 </div>
                        <div class="idItem">${i}</div>
                    </div>
                `);
        if (oldPart[dataPart][0] == i) {
          select2(i);
        }
      }
    }
  });
});

function selectPart(element) {
  dataPart = element.dataset.idpart;
  $(".menuType").find("img").css("filter", "brightness(100%)");
  $(".menuType").removeClass("ativada");
  $(element).addClass("ativada");
  $.post("http://nyo_barbershop/updateGui", JSON.stringify({ part: dataPart }));
}

function changeColor(color, type) {
  $.post(
    "http://nyo_barbershop/changeColor",
    JSON.stringify({ dataType: dataPart, color: color, type: type })
  );
}

function select(element) {
  partId = element.dataset.id;
  $(".lista").removeClass("activeLista");
  $(element).addClass("activeLista");
  oldPart[dataPart][0] = partId;
  $.post(
    "http://nyo_barbershop/changeCustom",
    JSON.stringify({ type: dataPart, id: partId })
  );
}

function select2(id) {
  partId = id;
  $(".lista").removeClass("activeLista");
  $(`#${dataPart}${id}`).addClass("activeLista");
  oldPart[dataPart][0] = partId;
}

$("#esquerda").click(function () {
  $.post("http://nyo_barbershop/leftHeading", JSON.stringify({ value: 10 }));
});

$("#direita").click(function () {
  $.post("http://nyo_barbershop/rightHeading", JSON.stringify({ value: 10 }));
});

$("#colorx").click(function () {
  if (mostrando == 0) {
    $("#cores").slideDown(0);
    mostrando = 1;
  } else {
    $("#cores").slideUp(1);
    mostrando = 0;
  }
});

$("#cart").click(function () {
  $("#container").fadeOut();
  $("#cores").slideUp(0);
  $.post(
    "http://nyo_barbershop/payament",
    JSON.stringify({ price: $("#totalDireita").text(), parts: oldPart })
  );
  $("#totalDireita").html("0");
});
