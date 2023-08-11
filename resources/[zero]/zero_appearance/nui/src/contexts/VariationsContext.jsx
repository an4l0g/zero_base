import { createContext, useState } from "react";

const VariationsContext = createContext({});

export const VariationsProvider = ({ children }) => {
  const [variations, setVariations] = useState({});

  return (
    <VariationsContext.Provider value={{ variations, setVariations }}>
      {children}
    </VariationsContext.Provider>
  );
};

export default VariationsContext;
