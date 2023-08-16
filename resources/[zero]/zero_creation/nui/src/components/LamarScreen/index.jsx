import React, { useCallback } from "react";
import * as S from "./styles";
import useRequest from "../../hooks/useRequest";

function LamarScreen({ setLamar }) {
  const { request } = useRequest();

  const handleCloseLamarScreen = useCallback(() => {
    setLamar(false);
    request("closeLamarScreen");
  }, [setLamar]);

  return (
    <S.Container>
      <S.Logo src="https://media.discordapp.net/attachments/1059878373737893918/1125947172165255178/zero_small.png?width=988&height=346" />
      <S.Content>
        <S.Title>
          Seja bem-vindo(a) à <b>Zero City</b>!<br />
        </S.Title>
        <S.Description>
          Parece que você esqueceu a pistola que o Lamar te presenteou no carro.
          Esta pode ser a chance perfeita para refletir sobre suas ações.{" "}
          <b>
            Lembre-se: a vida no crime não é o único caminho para o sucesso. Há
            muitas oportunidades esperando por você!
          </b>
        </S.Description>
        <S.Button onClick={handleCloseLamarScreen}>Entendido!</S.Button>
      </S.Content>
    </S.Container>
  );
}

export default LamarScreen;
