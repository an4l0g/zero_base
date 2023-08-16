import * as S from "./styles";

function Item({ data, onClick }) {
  return (
    <S.Container onClick={onClick}>
      <S.Image src={data.image ?? ""} />
      <S.Title>{data.title ?? ""}</S.Title>
    </S.Container>
  );
}

export default Item;
