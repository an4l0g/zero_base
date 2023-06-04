import * as S from "./styles";
import { MdOutlineRadio } from "react-icons/md";
import { LuClock3 } from "react-icons/lu";
import { BiMicrophone } from "react-icons/bi";

function TopInfos({ data }) {
  return (
    <S.Wrap>
      {data.radio !== 0 && (
        <S.Info>
          <MdOutlineRadio /> {data.radio}
        </S.Info>
      )}
      <S.Info talking={data.talking}>
        <BiMicrophone /> {data.voice}
      </S.Info>
      <S.Info>
        <LuClock3 /> {data.time}
      </S.Info>
    </S.Wrap>
  );
}

export default TopInfos;
