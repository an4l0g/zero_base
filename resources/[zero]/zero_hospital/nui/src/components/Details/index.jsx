import * as S from "./styles";

import { AiOutlineClose } from "react-icons/ai";

function Details() {
  return (
    <S.Details>
      <S.BackImage src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=810&height=282" />
      <S.Content>
        <S.CloseButton>
          <AiOutlineClose />
        </S.CloseButton>
        <S.Form>
          <S.Title>
            <span>#1</span> - Analog Papalombo
          </S.Title>
          <S.Group>
            <S.Input>
              <S.Label>Tipo de atendimento:</S.Label>
              <S.Select>
                <option value="cirurgia">Cirurgia Plástica</option>
                <option value="medicamento">Medicamento</option>
                <option value="tratamento">Tratamento</option>
              </S.Select>
            </S.Input>
            <S.Input>
              <S.Label>Valor do atendimento:</S.Label>
              <S.Price value={"5.000"} placeholder="Valor" />
            </S.Input>
          </S.Group>
          <S.Group>
            <S.Input>
              <S.Label>Detalhes de atendimento:</S.Label>
              <S.Textarea rows={5}></S.Textarea>
            </S.Input>
            <S.Input>
              <S.Label>Solicitação do paciente:</S.Label>
              <S.Textarea disabled rows={5}></S.Textarea>
            </S.Input>
          </S.Group>
          <S.Group>
            <S.Button>Registrar Atendimento</S.Button>
            <S.Datetime>22/04/2022 às 20h00</S.Datetime>
          </S.Group>
        </S.Form>
      </S.Content>
    </S.Details>
  );
}

export default Details;
