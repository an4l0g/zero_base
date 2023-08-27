import * as S from "./styles";

function DisplayParents({ parent1, parent2 }) {
  return (
    <S.Container>
      <S.Parent1
        src={`http://104.234.189.131/zero_creation/parents/${parent1}.png`}
      />
      <S.Parent2
        src={`http://104.234.189.131/zero_creation/parents/${parent2}.png`}
      />
    </S.Container>
  );
}

export default DisplayParents;
