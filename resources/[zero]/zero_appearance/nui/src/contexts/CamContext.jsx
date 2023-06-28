import { createContext, useEffect, useState } from "react";
import useRequest from "../hooks/useRequest";

const CamContext = createContext({ rotation: 0, type: "body" });

export const CamProvider = ({ children }) => {
  const [cam, setCam] = useState({ rotation: 0, type: "body" });
  const { request } = useRequest();

  useEffect(() => {
    request("changeCam", cam);
  }, [cam, request]);

  return (
    <CamContext.Provider value={{ cam, setCam }}>
      {children}
    </CamContext.Provider>
  );
};

export default CamContext;
