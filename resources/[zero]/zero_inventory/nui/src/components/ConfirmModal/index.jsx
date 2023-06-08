import React, {
  useCallback,
  useContext,
  useEffect,
  useRef,
  useState,
} from "react";
import { ConfirmModalContext } from "../../contexts/ConfirmModalContext";
import ContentItem from "../Item/ContentItem";
import * as S from "./styles";

function ConfirmModal() {
  const { confirmModal, setConfirmModal } = useContext(ConfirmModalContext);
  const [amount, setAmount] = useState(0);
  const inputRef = useRef(null);

  useEffect(() => {
    if (confirmModal.item) {
      setAmount(confirmModal.item.amount);
      inputRef.current.focus();
    }
  }, [confirmModal]);

  const closeModal = () => setConfirmModal({});

  const isButtonDisabled = useCallback(() => {
    return +amount <= 0 || +amount > +confirmModal.item.amount;
  }, [amount, confirmModal]);

  const handleAction = useCallback(async () => {
    confirmModal.action(confirmModal.item, confirmModal.pos, amount);
    closeModal();
  }, [confirmModal, amount]);

  if (confirmModal.item) {
    return (
      <S.Wrap>
        <S.Backdrop onClick={closeModal} />
        <S.Container>
          <ContentItem item={confirmModal.item} isPreview={true} />
          <S.InputAmount
            min={1}
            max={confirmModal.item.amount}
            type="number"
            ref={inputRef}
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
          />
          <S.BtnConfirm disabled={isButtonDisabled()} onClick={handleAction}>
            Confirmar
          </S.BtnConfirm>
        </S.Container>
      </S.Wrap>
    );
  } else <></>;
}

export default ConfirmModal;
