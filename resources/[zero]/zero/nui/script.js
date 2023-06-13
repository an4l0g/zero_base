$(document).ready(() => {
  window.addEventListener("message", function ({ data }) {
    if (data.action == "login") {
      $("#whitelist").fadeIn();
      $("#user_id b").text(data.user_id);
    }

    if (data.action == "hideMenu") $("#whitelist").fadeOut();
  });
});

const openNavigator = (button) => {
  if (button == "discord")
    window.invokeNative("openUrl", "https://discord.gg/invasaoz");

  if (button == "instagram")
    window.invokeNative("openUrl", "https://www.instagram.com/invasaozrp/");

  if (button == "tiktok")
    window.invokeNative("openUrl", "https://www.tiktok.com/@invasaozrp");
};

const confirm = () => {
  $.post("https://zero/checkWhitelist", JSON.stringify({}), (data) => {
    if (data.status) {
      $.post("http://zero/closeLogin", JSON.stringify({}));
    } else {
      $(".error").fadeIn();
      setTimeout(() => {
        $(".error").fadeOut();
      }, 3000);
    }
  });
};

$("#cta_liberar").on("click", confirm);
