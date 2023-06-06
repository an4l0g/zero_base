import { useEffect, useState } from "react";
import * as S from "./styles";

function DisplayParents({ parent1, parent2 }) {
  const [parent1Img, setParent1Img] = useState("");
  const [parent2Img, setParent2Img] = useState("");

  useEffect(() => {
    import(`../../../../assets/parents/${parent1}.png`).then((image) => {
      setParent1Img(image.default);
    });

    import(`../../../../assets/parents/${parent2}.png`).then((image) => {
      setParent2Img(image.default);
    });
  }, [parent1, parent2]);

  return (
    <S.Container>
      <S.Parent1 src={parent1Img} />
      <S.Parent2 src={parent2Img} />
    </S.Container>
  );
}

export default DisplayParents;
