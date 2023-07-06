import { createContext, useState } from "react";

const AppearanceContext = createContext({});

export const AppearanceProvider = ({ children }) => {
  const [appearance, setAppearance] = useState({});

  return (
    <AppearanceContext.Provider value={{ appearance, setAppearance }}>
      {children}
    </AppearanceContext.Provider>
  );
};

export default AppearanceContext;
