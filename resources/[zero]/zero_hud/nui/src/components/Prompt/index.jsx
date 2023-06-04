import * as S from "./styles";

function Prompt() {
  return (
    <S.Container>
      <S.Wrap>
        <S.Form>
          <S.Header>
            <S.Title>Título da mensagem</S.Title>
            <S.Steps>1/3</S.Steps>
          </S.Header>
          <S.Textarea rows={7}></S.Textarea>
          <S.Footer>
            Utilze [Esc] para cancelar e [Tab] para continuar.
          </S.Footer>
        </S.Form>
      </S.Wrap>
    </S.Container>
  );
}

export default Prompt;
