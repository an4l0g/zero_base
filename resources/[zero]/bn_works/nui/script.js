var works;

const actions = {
  open: ({ work, payment, routes, image, job }) => {
    works = job;
    $("#works").fadeIn();
    $("#works .wrap").css("display", "flex");
    $("#work").text(work);
    $("#job").html(`Emprego: <b>${job}</b>`);
    $("#value").html(`Pagamento: <b>${payment}</b>`);
    $("#routes").html(`Rotas: <b>${routes}</b>`);
    $("#job_image").attr("src", image);
  },
  inWork: ({ show }) => {
    if (show) {
      $("#works").fadeIn();
      $("#works .in-work").css("display", "flex");
    } else {
      $("#works").fadeOut();
      $("#works .in-work").css("display", "none");
    }
  },
};

$(document).ready(() => {
  window.addEventListener("message", (event) => {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });

  document.onkeyup = (event) => {
    if (event.key == "Escape") {
      closeNui();
    }
  };

  $("#button").on("click", function () {
    $("#works").fadeOut();
    $("#works .wrap").css("display", "none");
    $.post(`http://bn_works/startJob`, JSON.stringify({ works }));
  });
});

function closeNui() {
  $("#works").fadeOut();
  $.post(`http://bn_works/close`, JSON.stringify({}));
}
