const formatDate = (currentDate) => {
  var date = new Date(currentDate);
  var dateString = date.toLocaleDateString("pt-BR");
  var timeString = date.toLocaleTimeString("pt-BR");
  var dateTimeString = dateString + " " + timeString;
  return dateTimeString;
};

const methods = {
  open: ({ rankList }) => {
    $("#list").html("");
    $("#title").text("Ranking de organizações");

    rankList.map((item, index) => {
      $("#list").append(`
        <li>
          <div class="info f1">${index + 1}#</div>
          <div class="info">${item.org}</div>
          <div class="info"><div class="pts">${
            item.total_points
          } pontos</div></div>
          <div class="info cta">
            <button data-org="${item.org}">Detalhes</button>
          </div>
        </li>
      `);
    });
    $("#reputation").fadeIn();
  },
  selectOrg: ({ org, activityList }) => {
    $("#list").html("");
    $("#title").text(`${org} - Atividades`);

    activityList.map((item, index) => {
      $("#list").append(`
        <li>
          <div class="info f1"><div class="pts">${
            item.points
          } pontos</div></div>
          <div class="info left">${item.description}</div>
          <div class="info f1">${formatDate(item.created_at)}</div>
        </li>
      `);
    });
    $("#reputation").fadeIn();
  },
};

window.addEventListener("message", (event) => {
  const { action } = event.data;
  methods[action](event.data);
});

$(document).on("click", ".info button", function () {
  $.post(
    "http://zero_reputation/selectOrg",
    JSON.stringify({
      org: $(this).data("org"),
    })
  );
});

$(document).on("click", "header .close", function () {
  $("#list").html("");
  $.post("http://zero_reputation/close", "[]");
  $("#reputation").fadeOut();
});

document.onkeyup = (event) => {
  if (event.key == "Escape") {
    $("#list").html("");
    $.post("http://zero_reputation/close", "[]");
    $("#reputation").fadeOut();
  }
};
