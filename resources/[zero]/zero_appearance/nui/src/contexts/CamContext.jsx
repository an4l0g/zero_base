import { createContext, useEffect, useState, useRef } from "react";
import useRequest from "../hooks/useRequest";

const CamContext = createContext({ rotation: 0, type: "body" });

export const CamProvider = ({ children }) => {
  const firstRender = useRef(true);
  const [cam, setCam] = useState({ rotation: 0, type: "body" });
  const { request } = useRequest();

  useEffect(() => {
    if (firstRender.current) {
      firstRender.current = false;
      return;
    }
    request("changeCam", cam);
  }, [cam, request]);

  return (
    <CamContext.Provider value={{ cam, setCam }}>
      {children}
    </CamContext.Provider>
  );
};

export default CamContext;
