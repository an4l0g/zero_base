import { useCallback, useEffect, useRef } from "react";
import * as S from "./styles";
import useRequest from "../../hooks/useRequest";
import { AiOutlineCopy } from "react-icons/ai";

function Clipboard({ clipboard, setClipboard }) {
  const textareaRef = useRef();
  const { request } = useRequest();

  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.focus();
      textareaRef.current.select();
    }
  });

  const handleCloseClipboard = useCallback(() => {
    request("close");
    setClipboard({});
  }, [request, setClipboard]);

  const handleKeyDown = (e) => {
    if (e.keyCode === 27) handleCloseClipboard();
  };

  return (
    <>
      {clipboard.title && (
        <S.Container onKeyDown={handleKeyDown}>
          <S.Wrap>
            <S.Form>
              <S.Header>
                <S.Title>{clipboard.title}</S.Title>
                <S.IconCopy>
                  <AiOutlineCopy />
                </S.IconCopy>
              </S.Header>
              <S.Textarea
                ref={textareaRef}
                rows={7}
                value={clipboard.value}
              ></S.Textarea>
              <S.Footer>Utilze [Esc] para cancelar.</S.Footer>
            </S.Form>
          </S.Wrap>
        </S.Container>
      )}
    </>
  );
}

export default Clipboard;
