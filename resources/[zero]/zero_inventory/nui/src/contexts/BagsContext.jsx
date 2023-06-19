import { createContext, useState } from "react";

export const BagsContext = createContext({
  bags: {},
  setBags: () => {},
});

function BagsProvider({ children }) {
  const [bags, setBags] = useState({});

  return (
    <BagsContext.Provider value={{ bags, setBags }}>
      {children}
    </BagsContext.Provider>
  );
}

export default BagsProvider;
