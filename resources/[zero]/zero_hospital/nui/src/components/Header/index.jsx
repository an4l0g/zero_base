import { useContext } from "react";
import Input from "../Input";
import NotifyButton from "../NotifyButton";
import * as S from "./styles";
import PainelContext from "../../contexts/PainelContext";

function Header({ search, setSearch }) {
  const { painel } = useContext(PainelContext);

  return (
    <S.Header>
      <S.Title>
        Centro <span>Médico</span>
      </S.Title>
      <S.Right>
        <Input
          placeholder="Colaborador ou paciente"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />
        <NotifyButton notifies={painel.pendingServicesAmount} />
      </S.Right>
    </S.Header>
  );
}

export default Header;
