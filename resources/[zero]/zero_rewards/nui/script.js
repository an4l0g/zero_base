const actions = {
  open: ({ rank, rewards }) => {
    clearNui();
    $("#rewards").fadeIn();
    if (rank.length == 7) {
      renderTop3(rank);
    }
    $("#count-rewards").text(rewards);
    renderRank(rank);
  },
};

const renderImage = (image) => {
  return image
    ? image
    : "https://media.discordapp.net/attachments/1059878373737893918/1152051446947254352/355424122_220579397519143_5971142068866142494_n.png?width=120&height=120";
};

const calculateTime = (time) => {
  return Math.floor(time / 60) + " horas e " + (time % 60) + " minutos";
};

const renderTop3 = (rank) => {
  $(".top3").css("height", "17rem");
  $(".top3").append(`
      <li id="item-top2">
          <div class="wrap-image">
          <div class="rank-number">2º</div>
          <img
              src="${renderImage(rank[1].image)}"
          />
          </div>
          <div class="name">${rank[1].name}</div>
          <div class="time">${calculateTime(rank[1].online_time)}</div>
      </li>
    `);
  $(".top3").append(`
      <li id="item-top1">
          <div class="wrap-image">
          <div class="rank-number">1º</div>
          <img
              src="${renderImage(rank[0].image)}"
          />
          </div>
          <div class="name">${rank[0].name}</div>
          <div class="time">${calculateTime(rank[0].online_time)}</div>
      </li>
    `);
  $(".top3").append(`
      <li id="item-top3">
          <div class="wrap-image">
          <div class="rank-number">3º</div>
          <img
              src="${renderImage(rank[2].image)}"
          />
          </div>
          <div class="name">${rank[2].name}</div>
          <div class="time">${calculateTime(rank[2].online_time)}</div>
      </li>
    `);
};

const renderRank = (rank) => {
  if (rank.length == 7) {
    rank.slice(3, 7).map((item, index) => {
      $("#rank-list").append(`
            <li>
              <div class="position">#${index + 4}</div>
              <div class="name">${item.name}</div>
              <div class="time">${calculateTime(item.online_time)}</div>
            </li>
        `);
    });
  } else {
    rank.map((item, index) => {
      $("#rank-list").append(`
            <li>
              <div class="position">#${index + 1}</div>
              <div class="name">${item.name}</div>
              <div class="time">${calculateTime(item.online_time)}</div>
            </li>
        `);
    });
  }
};

const clearNui = () => {
  $(".top3").css("height", "0");
  $(".top3").html("");
  $("#rank-list").html("");
};

const closeNui = () => {
  $("#rewards").fadeOut();
  clearNui();
  $.post("http://zero_rewards/close", "[]");
};

$(document).on("click", "#btn-get-rewards", function () {
  $.post("http://zero_rewards/openReward", "[]");
  closeNui();
});

document.onkeyup = (event) => {
  if (event.key == "Escape") {
    closeNui();
  }
};

window.addEventListener("message", (event) => {
  const { action } = event.data;
  if (actions[action]) actions[action](event.data);
});
