import { useCallback, useState } from "react";
import * as S from "./styles";
import { FaBell } from "react-icons/fa";
import { FiCheck, FiX } from "react-icons/fi";

function NotifyButton({ notifies }) {
  const [showModal, setShowModal] = useState(false);

  const handleOpenModal = useCallback(() => {
    if (showModal) {
      setShowModal(false);
    } else {
      setShowModal(true);
    }
  }, [showModal, setShowModal]);

  return (
    <S.WrapButton>
      <S.Button onClick={handleOpenModal}>
        <S.WrapNotifies>{notifies}</S.WrapNotifies>
        <FaBell />
      </S.Button>
      {showModal && notifies > 0 && (
        <>
          <S.BackModal onClick={() => setShowModal(false)} />
          <S.ConfirmModal>
            <S.Description>Quer assumir um chamado?</S.Description>
            <S.Actions>
              <S.ResponseButton className="accept">
                <FiCheck />
              </S.ResponseButton>
              <S.ResponseButton className="reject">
                <FiX />
              </S.ResponseButton>
            </S.Actions>
          </S.ConfirmModal>
        </>
      )}
    </S.WrapButton>
  );
}

export default NotifyButton;
