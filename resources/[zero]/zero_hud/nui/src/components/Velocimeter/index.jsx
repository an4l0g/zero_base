import * as S from "./styles";

import { HiOutlineLockClosed } from "react-icons/hi";
import { LuFuel } from "react-icons/lu";
import { BsGear } from "react-icons/bs";
import { TbUserOff } from "react-icons/tb";
import { GiGearStickPattern } from "react-icons/gi";

function Velocimeter({ data }) {
  return (
    <>
      {data.vehHud && (
        <S.Velocimeter>
          <S.Velocity>
            <span>{data.speed}</span>
            <small>KM/H</small>
          </S.Velocity>
          <S.InfosVeh>
            <S.Info className="gear">
              <GiGearStickPattern />
              {data.gear}
            </S.Info>
            <S.Info>
              <LuFuel />
              <S.StatusIndicator height={data.fuel} />
            </S.Info>
            <S.Info>
              <HiOutlineLockClosed />
              <S.StatusIndicator height={data.locked * 100} />
            </S.Info>
            <S.Info>
              <TbUserOff />
              <S.StatusIndicator height={data.seatbelt * 100} />
            </S.Info>
            <S.Info>
              <BsGear />
              <S.StatusIndicator height={data.engineHealth} />
            </S.Info>
          </S.InfosVeh>
        </S.Velocimeter>
      )}
    </>
  );
}

export default Velocimeter;
