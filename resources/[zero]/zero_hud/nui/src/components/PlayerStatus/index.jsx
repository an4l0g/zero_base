import * as S from "./styles";

import {
  FaHeart,
  FaWineGlass,
  FaHamburger,
  FaShieldAlt,
  FaLungs,
} from "react-icons/fa";

function PlayerStatus({ data }) {
  return (
    <S.Wrap>
      <S.Status>
        <S.StatusIndicator height={data.health} />
        <S.StatusNumberWrap>
          <FaHeart />
          {data.health}%
        </S.StatusNumberWrap>
      </S.Status>
      <S.Status>
        <S.StatusIndicator height={data.armour} />
        <S.StatusNumberWrap>
          <FaShieldAlt />
          {data.armour}%
        </S.StatusNumberWrap>
      </S.Status>
      <S.Status>
        <S.StatusIndicator height={100 - data.hunger} />
        <FaHamburger />
      </S.Status>
      <S.Status>
        <S.StatusIndicator height={100 - data.thirst} />
        <FaWineGlass />
      </S.Status>
      {data.oxygen !== -1 && (
        <S.Status>
          <S.StatusIndicator height={data.oxygen} />
          <FaLungs />
        </S.Status>
      )}
    </S.Wrap>
  );
}

export default PlayerStatus;
