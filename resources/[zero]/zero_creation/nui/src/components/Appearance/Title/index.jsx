import * as S from "./styles";

function Title({ icon, title, space = false }) {
  return (
    <S.Container space={space}>
      <S.WrapIcon>{icon}</S.WrapIcon>
      <S.Title>{title}</S.Title>
    </S.Container>
  );
}

export default Title;
