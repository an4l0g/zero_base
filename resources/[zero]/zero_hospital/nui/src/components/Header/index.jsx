import Input from "../Input";
import NotifyButton from "../NotifyButton";
import * as S from "./styles";

function Header({ search, setSearch }) {
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
        <NotifyButton notifies={10} />
      </S.Right>
    </S.Header>
  );
}

export default Header;
