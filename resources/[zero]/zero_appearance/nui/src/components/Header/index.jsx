import * as S from "../GenericalStyles";
import { useContext } from "react";
import CamContext from "../../contexts/CamContext";
import { MdFace } from "react-icons/md";
import { IoMdBody } from "react-icons/io";

function Header({ title, icon }) {
  const { cam, setCam } = useContext(CamContext);

  const handleChangeCam = () => {
    if (cam.type === "body") {
      setCam((old) => ({
        ...old,
        type: "head",
      }));
    } else {
      setCam((old) => ({
        ...old,
        type: "body",
      }));
    }
  };

  return (
    <S.Header>
      <S.HeaderDivider position="flex-start">
        <S.Logo src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=100&height=35" />
      </S.HeaderDivider>
      <S.HeaderDivider position="center">
        <S.Title>
          <S.WrapIcon>{icon}</S.WrapIcon>
          {title}
        </S.Title>
      </S.HeaderDivider>
      <S.HeaderDivider position="flex-end">
        <S.PovButton onClick={handleChangeCam}>
          {cam.type === "head" ? <MdFace /> : <IoMdBody />}
        </S.PovButton>
      </S.HeaderDivider>
    </S.Header>
  );
}

export default Header;
