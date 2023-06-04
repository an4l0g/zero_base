import { toast } from "react-toastify";
import * as GS from "../styles";
import { VscRadioTower, VscBell } from "react-icons/vsc";
import { BsClockHistory } from "react-icons/bs";
import { AiOutlineQuestion } from "react-icons/ai";
import AudioAdmMessage from "../assets/sounds/message.ogg";

function useNotification() {
  const launchNotify = (title, message, time = 5000) => {
    toast(
      <GS.ContainerNotify>
        <VscBell />
        <GS.ContentNotify>
          <strong>{title}</strong>
          <p dangerouslySetInnerHTML={{ __html: message }} />
        </GS.ContentNotify>
      </GS.ContainerNotify>,
      { autoClose: time, hideProgressBar: true, position: "top-right" }
    );
  };

  const launchProgressBar = (title, time = 5000) => {
    toast(
      <GS.ContainerNotify>
        <BsClockHistory />
        <GS.ContentNotify>
          <strong>{title}</strong>
        </GS.ContentNotify>
      </GS.ContainerNotify>,
      { autoClose: time, position: "bottom-center" }
    );
  };

  const launchRequest = (title, time = 5000) => {
    toast(
      <GS.ContainerNotify>
        <AiOutlineQuestion />
        <GS.ContentNotify>
          <strong>{title}</strong>
          <GS.RequestActions>
            <span>
              <b>[Y]</b> Aceitar
            </span>
            <span>
              <b>[U]</b> Rejeitar
            </span>
          </GS.RequestActions>
        </GS.ContentNotify>
      </GS.ContainerNotify>,
      { autoClose: time, position: "top-center" }
    );
  };

  const launchOrgNotify = (title, message, author, playAudio, time = 5000) => {
    if (playAudio) {
      const audio = new Audio(AudioAdmMessage);
      audio.volume = 0.2;
      audio.play();
    }
    toast(
      <GS.ContainerNotify>
        <VscRadioTower />
        <GS.ContentNotify>
          <strong>{title}</strong>
          <p dangerouslySetInnerHTML={{ __html: message }} />
          <span className="author">{author}</span>
        </GS.ContentNotify>
      </GS.ContainerNotify>,
      { autoClose: time, hideProgressBar: true, position: "top-right" }
    );
  };

  return {
    launchNotify,
    launchOrgNotify,
    launchProgressBar,
    launchRequest,
  };
}

export default useNotification;
