import { useCallback, useEffect, useState } from "react";
import { ThemeProvider } from "styled-components";
import * as S from "./styles";
import Logo from "./components/Logo";
import TopInfos from "./components/TopInfos";
import PlayerStatus from "./components/PlayerStatus";
import Velocimeter from "./components/Velocimeter";
import "react-toastify/dist/ReactToastify.css";
import { ToastContainer } from "react-toastify";
import useNotification from "./hooks/useNotification";
// import Prompt from "./components/Prompt";

function App() {
  const [time, setTime] = useState("");
  const [health, setHealth] = useState(0);
  const [armour, setArmour] = useState(0);
  const [speed, setSpeed] = useState(0);
  const [fuel, setFuel] = useState(0);
  const [gear, setGear] = useState(0);
  const [engineHealth, setEngineHealth] = useState(1);
  // const [street, setStreet] = useState("");
  const [vehHud, setVehHud] = useState(false);
  const [hud, setHud] = useState(true);
  const [seatbelt, setSeatbelt] = useState(false);
  const [locked, setLocked] = useState(false);
  const [talking, setTalking] = useState(false);
  const [voice, setVoice] = useState("Normal");
  const [hunger, setHunger] = useState(0);
  const [thirst, setThirst] = useState(0);
  const [radio, setRadio] = useState(0);
  const [oxygen, setOxygen] = useState(-1);
  // const [toxic, setToxic] = useState(0);
  // const [stress, setStress] = useState(0);

  const { launchNotify, launchProgressBar, launchRequest, launchOrgNotify } =
    useNotification();

  const nuiMessage = useCallback(
    (event) => {
      const actions = {
        updateTime: (value) => setTime(value),
        updateHealth: (value) => setHealth(value),
        updateArmour: (value) => setArmour(value),
        updateSpeed: (value) => setSpeed(value),
        updateFuel: (value) => setFuel(value),
        updateGear: (value) => setGear(value),
        updateEngineHealth: (value) => setEngineHealth(value),
        updateHudVehicle: (value) => setVehHud(value),
        updateHud: (value) => setHud(value),
        // updateStreet: (value) => setStreet(value),
        updateSeatbelt: (value) => setSeatbelt(value),
        updateLocked: (value) => setLocked(value),
        updateTalking: (value) => setTalking(value),
        updateVoice: (value) => setVoice(value),
        updateHunger: (value) => setHunger(value),
        updateThirst: (value) => setThirst(value),
        updateRadioChannel: (value) => setRadio(value),
        updateOxygen: (value) => setOxygen(value),
        // updateToxic: (value) => setToxic(value),
        // updateStress: (value) => setStress(value),
        notify: ({ title, message, time }) => {
          launchNotify(title, message, time);
        },
        progress: ({ title, time }) => {
          launchProgressBar(title, time);
        },
        request: ({ title, time }) => {
          launchRequest(title, time);
        },
      };
      const { method, data } = event.data;
      if (method) {
        actions[method](data);
      }
    },
    [launchNotify, launchProgressBar]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage]);

  return (
    <ThemeProvider theme={S.theme}>
      {hud && (
        <>
          <ToastContainer theme="dark" position="bottom-center" />
          <S.GlobalStyle />
          {/* <Prompt /> */}
          <S.WrapHud>
            <Logo />
            <TopInfos
              data={{
                time,
                voice,
                talking,
                radio,
              }}
            />
            <S.BottomRight>
              <Velocimeter
                data={{
                  vehHud,
                  speed,
                  fuel,
                  gear,
                  locked,
                  engineHealth,
                  seatbelt,
                }}
              />
              <PlayerStatus
                data={{
                  health: health < 0 ? 0 : Math.floor(health),
                  armour: armour < 0 ? 0 : Math.floor(armour),
                  hunger,
                  thirst,
                  oxygen,
                }}
              />
            </S.BottomRight>
          </S.WrapHud>
        </>
      )}
    </ThemeProvider>
  );
}

export default App;
