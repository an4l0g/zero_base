import { createContext, useCallback, useEffect, useState } from "react";
import useRequest from "../hooks/useRequest";
export const CharacterContext = createContext({});

export const CharacterProvider = ({ children }) => {
  const [character, setCharacter] = useState({
    name: "",
    surname: "",
    gender: "masculino",
    age: 18,
    fatherId: 0,
    motherId: 21,
    shapeMix: 0.6,
    colorFather: 0,
    colorMother: 0,
    skinMix: 0,
    eyesColor: 0,
    eyesOpening: 0,
    eyebrowsHeight: 0,
    eyebrowsWidth: 0,
    eyebrowsModel: 0,
    eyebrowsColor: 0,
    eyebrowsOpacity: 0.99,
    noseWidth: 0,
    noseHeight: 0,
    noseLength: 0,
    noseBridge: 0,
    noseTip: 0,
    noseShift: 0,
    cheekboneHeight: 0,
    cheekboneWidth: 0,
    cheeksWidth: 0,
    lips: 0,
    jawWidth: 0,
    jawHeight: 0,
    chinLength: 0,
    chinPosition: 0,
    chinWidth: 0,
    chinShape: 0,
    neckWidth: 0,
    hairModel: 0,
    firstHairColor: 0,
    secondHairColor: 0,
    beardModel: -1,
    beardColor: 0,
    beardOpacity: 0.99,
    chestModel: -1,
    chestColor: 0,
    chestOpacity: 0.99,
    blushModel: -1,
    blushColor: 0,
    blushOpacity: 0.99,
    lipstickModel: -1,
    lipstickColor: 0,
    lipstickOpacity: 0.99,
    blemishesModel: -1,
    blemishesOpacity: 0.99,
    ageingModel: -1,
    ageingOpacity: 0.99,
    complexionModel: -1,
    complexionOpacity: 0.99,
    sundamageModel: -1,
    sundamageOpacity: 0.99,
    frecklesModel: -1,
    frecklesOpacity: 0.99,
    makeupModel: -1,
    makeupOpacity: 0.99,
  });

  const { request } = useRequest();

  const handleChangeCharacter = useCallback(async () => {
    await request("changeCharacter", character);
  }, [character, request]);

  useEffect(() => {
    handleChangeCharacter();
  }, [character, handleChangeCharacter]);

  return (
    <CharacterContext.Provider value={{ character, setCharacter }}>
      {children}
    </CharacterContext.Provider>
  );
};

export default CharacterContext;
