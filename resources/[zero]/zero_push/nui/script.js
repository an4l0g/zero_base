$(document).ready(function () {
  let blocked = false;
  let list = [];

  const actions = {
    show: ({ data }) => {
      if (list.length > 9) list.shift();

      const html = `
        <div class="container">
          <div class="infos">
            <header>
              <div class="code">${data.code}</div>
              <div class="hour">${data.hours}</div>
            </header>
            <h1>${data.title}</h1>
            <ul>
              ${
                data.officer
                  ? `<li><i class="fa-solid fa-user"></i> ${data.officer}</li>`
                  : ""
              }
              ${
                data.car
                  ? `<li><i class="fas fa-car"></i> ${data.car}</li>`
                  : ""
              }
              ${
                data.description
                  ? `<li><i class="fas fa-triangle-exclamation"></i> ${data.description}</li>`
                  : ""
              }
              <li>
                <i class="fas fa-street-view"></i> ${data.street}
              </li>
            </ul>
          </div>
          <div class="buttons">
            <ul>
              <li id="loc" data-x="${data.coords.x}" data-y="${
        data.coords.y
      }"><i class="fas fa-location-dot"></i></li>
            </ul>
          </div>
        </div>
      `;

      list.push(html);

      if (!blocked) {
        $(html)
          .prependTo(".wrapper")
          .hide()
          .show("slide", { direction: "left" }, 250)
          .delay(5000)
          .fadeOut(500);
      }
    },
    notifys: () => {
      if (list.length > 0) {
        showLast();
        post("open", {});
      }
    },
  };

  const hideAll = () => {
    blocked = false;
    $(".wrapper").css("overflow", "hidden");
    $(".wrapper").html("");
  };

  const showLast = () => {
    hideAll();
    blocked = true;
    $(".wrapper").css("overflow-y", "scroll");
    for (i in list) {
      $(list[i]).prependTo(".wrapper");
    }
  };

  const post = (link, json) => {
    $.post(`http://zero_push/${link}`, JSON.stringify(json));
  };

  $(document).on("click", "#loc", function () {
    hideAll();
    post("setWay", { x: $(this).attr("data-x"), y: $(this).attr("data-y") });
  });

  document.onkeyup = (event) => {
    if (event.key == "Escape") {
      hideAll();
      post("close", {});
    }
  };

  window.addEventListener("message", function (event) {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });
});
