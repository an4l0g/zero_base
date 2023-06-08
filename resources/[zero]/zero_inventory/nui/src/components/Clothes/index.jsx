import React from "react";
import Item from "../Item";
import * as S from "./styles";
import { FaRedhat, FaMask, FaTshirt } from "react-icons/fa";
import {
  GiMonclerJacket,
  GiArmoredPants,
  GiConverseShoe,
  GiEarrings,
  Gi3DGlasses,
  GiHeartNecklace,
  GiWinterGloves,
  GiBigDiamondRing,
  GiWatch,
} from "react-icons/gi";

function Clothes() {
  return (
    <S.Container>
      <Item icon={<FaRedhat />} bagType="clothes" />
      <Item icon={<FaMask />} bagType="clothes" />
      <Item icon={<FaTshirt />} bagType="clothes" />
      <Item icon={<GiMonclerJacket />} bagType="clothes" />
      <Item icon={<GiArmoredPants />} bagType="clothes" />
      <Item icon={<GiConverseShoe />} bagType="clothes" />

      <S.FloatItem top={50} right={5}>
        <Item icon={<GiEarrings />} bagType="clothes" />
      </S.FloatItem>
      <S.FloatItem top={50} left={10}>
        <Item icon={<Gi3DGlasses />} bagType="clothes" />
      </S.FloatItem>

      <S.FloatItem top={250} right={10}>
        <Item icon={<GiHeartNecklace />} bagType="clothes" />
      </S.FloatItem>
      <S.FloatItem top={250} left={10}>
        <Item icon={<GiWinterGloves />} bagType="clothes" />
      </S.FloatItem>

      <S.FloatItem top={360} right={10}>
        <Item icon={<GiBigDiamondRing />} bagType="clothes" />
      </S.FloatItem>
      <S.FloatItem top={360} left={10}>
        <Item icon={<GiWatch />} bagType="clothes" />
      </S.FloatItem>
    </S.Container>
  );
}

export default Clothes;
