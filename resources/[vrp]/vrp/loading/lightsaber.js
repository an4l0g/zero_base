var playlist = [
  // {
  //     "song": "Brazuca Halloween",
  //     "album": "Brazuca",
  //     "artist": "MC Paulinho o LOKO",
  //     "mp3": "http://189.127.164.170/songs/halloween.mp3"
  // },
  // {
  //   song: "Brazuca City",
  //   album: "Brazuca",
  //   artist: "MC Paulinho o LOKO",
  //   mp3: "http://189.127.164.170/songs/brazuca.mp3",
  // },
  // {
  //   song: "Rodinha da Bike",
  //   album: "Brazuca",
  //   artist: "MC Paulinho o LOKO",
  //   mp3: "http://189.127.164.170/songs/brazuca2.mp3",
  // },
  // {
  //   song: "Tchais",
  //   album: "Brazuca",
  //   artist: "MC Paulinho o LOKO",
  //   mp3: "http://189.127.164.170/songs/tchais.mp3",
  // },
];

var rot = 0;
var duration;
var playPercent;
var bufferPercent;
var currentSong = 0;
var arm_rotate_timer;
var arm = document.getElementById("arm");
var next = document.getElementById("next");
var song = document.getElementById("song");
var timer = document.getElementById("timer");
var music = document.getElementById("music");
var volume = document.getElementById("volume");
var playButton = document.getElementById("play");
var timeline = document.getElementById("slider");
var playhead = document.getElementById("elapsed");
var previous = document.getElementById("previous");
var pauseButton = document.getElementById("pause");
var bufferhead = document.getElementById("buffered");
var timelineWidth = timeline.offsetWidth - playhead.offsetWidth;
var visablevolume = document.getElementsByClassName("volume")[0];

music.addEventListener("ended", _next, false);
music.addEventListener(
  "timeupdate",
  ({ target }) => {
    if (target.duration) {
      playPercent = timelineWidth * (target.currentTime / target.duration);
      playhead.style.width = playPercent + "px";
      timer.innerHTML = formatSecondsAsTime(music.currentTime.toString());
    }
  },
  false
);
load();

function load() {
  pauseButton.style.visibility = "hidden";
  song.innerHTML = playlist[currentSong]["song"];
  song.title = playlist[currentSong]["song"];
  music.innerHTML =
    '<source src="' + playlist[currentSong]["mp3"] + '" type="audio/mp3">';
  music.load();
  setTimeout(() => music.play(), 1000);
}

function reset() {
  rotate_reset = setInterval(function () {
    if (rot == 0) {
      clearTimeout(rotate_reset);
    }
  }, 1);
  fireEvent(pauseButton, "click");
  playhead.style.width = "0px";
  bufferhead.style.width = "0px";
  timer.innerHTML = "0:00";
  music.innerHTML = "";
  currentSong = 0; // set to first song, to stay on last song: currentSong = playlist.length - 1;
  song.innerHTML = playlist[currentSong]["song"];
  song.title = playlist[currentSong]["song"];
  music.innerHTML =
    '<source src="' + playlist[currentSong].mp3 + '" type="audio/mp3">';
  music.load();
}

function formatSecondsAsTime(secs, format) {
  var hr = Math.floor(secs / 3600);
  var min = Math.floor((secs - hr * 3600) / 60);
  var sec = Math.floor(secs - hr * 3600 - min * 60);
  if (sec < 10) {
    sec = "0" + sec;
  }
  return min + ":" + sec;
}

function fireEvent(el, etype) {
  if (el.fireEvent) {
    el.fireEvent("on" + etype);
  } else {
    var evObj = document.createEvent("Events");
    evObj.initEvent(etype, true, false);
    el.dispatchEvent(evObj);
  }
}

function _next() {
  if (currentSong == playlist.length - 1) {
    reset();
  } else {
    fireEvent(next, "click");
  }
}

playButton.onclick = function () {
  music.play();
};

pauseButton.onclick = function () {
  music.pause();
};

music.addEventListener(
  "play",
  function () {
    playButton.style.visibility = "hidden";
    pause.style.visibility = "visible";
    rotate_timer = setInterval(function () {
      if (!music.paused && !music.ended && 0 < music.currentTime) {
      }
    }, 10);
    arm_rotate_timer = setInterval(function () {
      if (!music.paused && !music.ended && 0 < music.currentTime) {
        if (arm.style.transition != "") {
          setTimeout(function () {
            arm.style.transition = "";
          }, 1000);
        }
      }
    }, 1000);
  },
  false
);

music.addEventListener(
  "pause",
  function () {
    arm.setAttribute("style", "transition: transform 800ms;");
    arm.style.transform = "rotate(-45deg)";
    playButton.style.visibility = "visible";
    pause.style.visibility = "hidden";
    clearTimeout(rotate_timer);
    clearTimeout(arm_rotate_timer);
  },
  false
);

next.onclick = function () {
  arm.setAttribute("style", "transition: transform 800ms;");
  arm.style.transform = "rotate(-45deg)";
  clearTimeout(rotate_timer);
  clearTimeout(arm_rotate_timer);
  playhead.style.width = "0px";
  bufferhead.style.width = "0px";
  timer.innerHTML = "0:00";
  music.innerHTML = "";
  arm.style.transform = "rotate(-45deg)";
  armrot = -45;
  if (currentSong + 1 == playlist.length) {
    currentSong = 0;
    music.innerHTML =
      '<source src="' + playlist[currentSong]["mp3"] + '" type="audio/mp3">';
  } else {
    currentSong++;
    music.innerHTML =
      '<source src="' + playlist[currentSong]["mp3"] + '" type="audio/mp3">';
  }
  song.innerHTML = playlist[currentSong]["song"];
  song.title = playlist[currentSong]["song"];
  music.load();
  duration = music.duration;
  music.play();
};

previous.onclick = function () {
  arm.setAttribute("style", "transition: transform 800ms;");
  arm.style.transform = "rotate(-45deg)";
  clearTimeout(rotate_timer);
  clearTimeout(arm_rotate_timer);
  playhead.style.width = "0px";
  bufferhead.style.width = "0px";
  timer.innerHTML = "0:00";
  music.innerHTML = "";
  arm.style.transform = "rotate(-45deg)";
  armrot = -45;
  if (currentSong - 1 == -1) {
    currentSong = playlist.length - 1;
    music.innerHTML =
      '<source src="' + playlist[currentSong]["mp3"] + '" type="audio/mp3">';
  } else {
    currentSong--;
    music.innerHTML =
      '<source src="' + playlist[currentSong]["mp3"] + '" type="audio/mp3">';
  }
  song.innerHTML = playlist[currentSong]["song"];
  song.title = playlist[currentSong]["song"];
  music.load();
  duration = music.duration;
  music.play();
};

volume.oninput = function () {
  music.volume = volume.value;
  visablevolume.style.width = (80 - 11) * volume.value + "px";
};

music.addEventListener(
  "canplay",
  function () {
    duration = music.duration;
  },
  false
);

const bd = document.body,
  cur = document.getElementById("fare");
bd.addEventListener("mousemove", function (n) {
  (cur.style.left = n.clientX + "px"), (cur.style.top = n.clientY + "px");
});
