import Appearance from "./components/Appearance";
import Pov from "./components/Pov";
import * as S from "./styles";

function App() {
  return (
    <>
      <S.GlobalStyle />
      <S.WrapCreation>
        <Appearance />
        <Pov />
      </S.WrapCreation>
    </>
  );
}

export default App;
