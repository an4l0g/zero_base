import { createContext, useState } from "react";

export const ConfirmModalContext = createContext({
  confirmModal: {},
  setConfirmModal: () => {},
});

function ConfirmModalProvider({ children }) {
  const [confirmModal, setConfirmModal] = useState({});

  return (
    <ConfirmModalContext.Provider value={{ confirmModal, setConfirmModal }}>
      {children}
    </ConfirmModalContext.Provider>
  );
}

export default ConfirmModalProvider;
