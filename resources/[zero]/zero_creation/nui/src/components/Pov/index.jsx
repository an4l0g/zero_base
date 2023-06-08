import { useCallback, useEffect, useState } from "react";
import Slider from "../Slider";
import * as S from "./styles";
import { BiFace, BiBody } from "react-icons/bi";
import useRequest from "../../hooks/useRequest";

function Pov() {
  const [pov, setPov] = useState("body");
  const [rotate, setRotate] = useState(50);
  const { request } = useRequest();

  const handleChangePov = useCallback(async () => {
    await request("changePov", {
      pov,
      rotate,
    });
  }, [pov, rotate, request]);

  useEffect(() => {
    handleChangePov();
  }, [pov, rotate, handleChangePov]);

  return (
    <S.Container>
      <S.Buttons>
        <S.Button active={pov === "head"} onClick={() => setPov("head")}>
          <BiFace />
        </S.Button>
        <S.Button active={pov === "body"} onClick={() => setPov("body")}>
          <BiBody />
        </S.Button>
      </S.Buttons>
      <Slider
        label="Rotação"
        value={rotate}
        setValue={setRotate}
        min={0}
        max={360}
      />
    </S.Container>
  );
}

export default Pov;
