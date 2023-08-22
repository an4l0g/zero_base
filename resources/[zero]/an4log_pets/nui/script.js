const scriptName = "an4log_pets";
var allPets;
var current_pet_type;
var current_pet_variation = 0;
var current_action;

const actions = {
  hud_pet: ({ pet, enableAttack }) => {
    closeAllNuis();
    const {
      type,
      hunger,
      c_hunger,
      thirst,
      c_thirst,
      actions,
      name,
      variation,
    } = pet;
    $("#zPetHud").fadeIn();
    $("#pet-name").text(name);
    $("#img-pet").attr("src", urlImgPet(type + variation));

    updateStats(hunger, c_hunger, thirst, c_thirst, actions, enableAttack);
  },
  openForm: ({ pet_type, variations, default_variation }) => {
    $("#input-pet-name").val("");
    $("#img-adopt").attr("src", urlImgPet(pet_type + default_variation));
    current_pet_type = pet_type;
    current_pet_variation = default_variation;
    current_action = "form";

    if (variations) {
      updateVariations(variations);
    }

    $("#zPetForm").fadeIn();
  },
  update_pet: ({ pet, enableAttack }) => {
    const { hunger, c_hunger, thirst, c_thirst, actions } = pet;
    updateStats(hunger, c_hunger, thirst, c_thirst, actions, enableAttack);
  },
  list_pets: ({ pets }) => {
    allPets = pets;
    $("#pet-list").html("");
    $("#pet-list").hide();
    $("#empty-list").hide();
    if (pets.length > 0) {
      $("#pet-list").show();
      pets.map((pet, index) => {
        $("#pet-list").append(`<li class='${
          pet.is_dead ? "disabled" : ""
        }' data-ipet=${index} >
        <img id="img-adopt" src="./pets/${pet.pet_type + pet.variation}.png" />
        <div class="desc">
        <span class="name">${pet.pet_name}</span>
        ${pet.is_dead ? `<span class="status">Usar kit veterinário</span>` : ``}
        </div>
        </li>`);
      });
    } else {
      $("#empty-list").show();
    }
    $("#zPetList").fadeIn();
  },
  message: ({ message }) => {
    showMessage(message);
  },
  close: () => {
    closeAllNuis();
  },
};

$(document).on("click", "#pet-list li", function () {
  const iPet = $(this).data("ipet");
  $.post(
    `http://${scriptName}/selectPet`,
    JSON.stringify({
      pet: allPets[iPet],
    })
  );
});

$("#form_create_pet").on("submit", function (e) {
  e.preventDefault();
});

$(document).on("click", "#btn-adopt", () => {
  const name = $("#input-pet-name").val();
  $.post(
    `http://${scriptName}/adoptPet`,
    JSON.stringify({
      pet_name: name,
      pet_type: current_pet_type,
      variation: current_pet_variation,
    })
  );
  current_action = "formcompleted";
  closeAllNuis();
});

$(document).on("click", "#variation-list li", function () {
  $("#variation-list li").removeClass("active");
  $(this).addClass("active");
  current_pet_variation = $(this).data("index");
  $("#img-adopt").attr(
    "src",
    urlImgPet(current_pet_type + current_pet_variation)
  );
});

const showMessage = () => {
  const msg = $("#message");
  msg.html("");
  msg.text(message);
  msg.fadeIn(() => {
    setTimeout(() => {
      msg.fadeOu();
    }, 5000);
  });
};

const updateVariations = (variations) => {
  const varList = $("#variation-list");
  varList.html("");
  variations.map((variation, index) => {
    varList.append(
      `<li data-index="${index}" class="${
        index === 0 ? "active" : ""
      }" style="background-color: ${variation}90"></li>`
    );
  });
  varList.css("display", "flex");
};

const updateStats = (
  hunger,
  c_hunger,
  thirst,
  c_thirst,
  actions,
  enableAttack
) => {
  $(`.item-command`).css("display", "none");
  $(".bar.hunger").css("width", `${(hunger / c_hunger) * 100}%`);
  $(".bar.thirst").css("width", `${(thirst / c_thirst) * 100}%`);

  Object.keys(actions).map((item) => {
    if (actions[item].permission) {
      $(`.item-command#${item}`).css("display", "flex");

      if (item == "attack") $(`#target`).css("display", "block");
    }
  });

  if (!enableAttack) {
    $(`.item-command#attack`).css("display", "none");
    $(`#target`).css("display", "none");
  }
};

const urlImgPet = (pet) => `./pets/${pet}.png`;

window.addEventListener("message", (event) => {
  current_action = "";
  const { action } = event.data;
  if (actions[action]) actions[action](event.data);
});

window.onkeydown = function (data) {
  if (data.keyCode == 27) closeAllNuis();
};

const closeAllNuis = (returnItem) => {
  if (current_action == "form") {
    $.post(
      `http://${scriptName}/returnItem`,
      JSON.stringify({ pet_type: current_pet_type })
    );
  }

  $("#target").css("display", "none");
  $("#variation-list").css("display", "none");
  $("#zPetHud").fadeOut();
  $("#zPetForm").fadeOut();
  $("#zPetList").fadeOut();
  $.post(`http://${scriptName}/close`, JSON.stringify({}));
};
