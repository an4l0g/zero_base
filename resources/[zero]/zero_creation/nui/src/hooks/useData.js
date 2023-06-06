import { useEffect, useState } from "react";
import ParentsList from "../components/Appearance/Parents/parents.json";

function useData() {
  // Identity
  const [name, setName] = useState("");
  const [surname, setSurname] = useState("");
  const [gender, setGender] = useState(0);
  const [age, setAge] = useState(18);

  // Parents
  const [fatherId, setFatherId] = useState(0);
  const [motherId, setMotherId] = useState(ParentsList.length - 1);
  const [resemblance, setResemblance] = useState(0);
  const [colorFather, setColorFather] = useState(0);
  const [colorMother, setColorMother] = useState(0);
  const [skinMix, setSkinMix] = useState(0);

  // Face
  const [eyesColor, setEyesColor] = useState(0);
  const [eyesOpening, setEyesOpening] = useState(0);
  const [eyebrowsHeight, setEyebrowsHeight] = useState(0);
  const [eyebrowsWidth, setEyebrowsWidth] = useState(0);
  const [eyebrowsModel, setEyebrowsModel] = useState(0);
  const [eyebrowsColor, setEyebrowsColor] = useState(0);
  const [eyebrowsOpacity, setEyebrowsOpacity] = useState(0);

  const [noseWidth, setNoseWidth] = useState(0);
  const [noseHeight, setNoseHeight] = useState(0);
  const [noseLength, setNoseLength] = useState(0);
  const [noseBridge, setNoseBridge] = useState(0);
  const [noseTip, setNoseTip] = useState(0);
  const [noseShift, setNoseShift] = useState(0);

  const [cheekboneHeight, setCheekboneHeight] = useState(0);
  const [cheekboneWidth, setCheekboneWidth] = useState(0);
  const [cheeksWidth, setCheeksWidth] = useState(0);

  const [lips, setLips] = useState(0);
  const [jawWidth, setJawWidth] = useState(0);
  const [jawHeight, setJawHeight] = useState(0);

  const [chinLength, setChinLength] = useState(0);
  const [chinPosition, setChinPosition] = useState(0);
  const [chinWidth, setChinWidth] = useState(0);
  const [chinShape, setChinShape] = useState(0);

  const [neckWidth, setNeckWidth] = useState(0);

  // Hair
  const [hairModel, setHairModel] = useState(0);
  const [firstHairColor, setFirstHairColor] = useState(0);
  const [secondHairColor, setSecondHairColor] = useState(0);

  const [beardModel, setBeardModel] = useState(0);
  const [beardColor, setBeardColor] = useState(0);
  const [beardOpacity, setBeardOpacity] = useState(0);

  const [chestModel, setChestModel] = useState(0);
  const [chestColor, setChestColor] = useState(0);
  const [chestOpacity, setChestOpacity] = useState(0);

  const [blushModel, setBlushModel] = useState(0);
  const [blushColor, setBlushColor] = useState(0);
  const [blushOpacity, setBlushOpacity] = useState(0);

  const [lipstickModel, setLipstickModel] = useState(0);
  const [lipstickColor, setLipstickColor] = useState(0);
  const [lipstickOpacity, setLipstickOpacity] = useState(0);

  const [blemishesModel, setBlemishesModel] = useState(0);
  const [blemishesOpacity, setBlemishesOpacity] = useState(0);

  const [ageingModel, setAgeingModel] = useState(0);
  const [ageingOpacity, setAgeingOpacity] = useState(0);

  const [complexionModel, setComplexionModel] = useState(0);
  const [complexionOpacity, setComplexionOpacity] = useState(0);

  const [sundamageModel, setSundamageModel] = useState(0);
  const [sundamageOpacity, setSundamageOpacity] = useState(0);

  const [frecklesModel, setFrecklesModel] = useState(0);
  const [frecklesOpacity, setFrecklesOpacity] = useState(0);

  const [makeupModel, setMakeupModel] = useState(0);
  const [makeupOpacity, setMakeupOpacity] = useState(0);

  useEffect(() => {}, [
    name,
    surname,
    gender,
    age,
    fatherId,
    motherId,
    resemblance,
    colorFather,
    colorMother,
    skinMix,
    eyesColor,
    eyesOpening,
    eyebrowsHeight,
    eyebrowsWidth,
    eyebrowsModel,
    eyebrowsColor,
    eyebrowsOpacity,
    noseWidth,
    noseHeight,
    noseLength,
    noseBridge,
    noseTip,
    noseShift,
    cheekboneHeight,
    cheekboneWidth,
    cheeksWidth,
    lips,
    jawWidth,
    jawHeight,
    chinLength,
    chinPosition,
    chinWidth,
    chinShape,
    neckWidth,
    hairModel,
    firstHairColor,
    secondHairColor,
    beardModel,
    beardColor,
    beardOpacity,
    chestModel,
    chestColor,
    chestOpacity,
    blushModel,
    blushColor,
    blushOpacity,
    lipstickModel,
    lipstickColor,
    lipstickOpacity,
    blemishesModel,
    blemishesOpacity,
    ageingModel,
    ageingOpacity,
    complexionModel,
    complexionOpacity,
    sundamageModel,
    sundamageOpacity,
    frecklesModel,
    frecklesOpacity,
    makeupModel,
    makeupOpacity,
  ]);

  return {
    // Identity
    name: { get: name, set: setName },
    surname: { get: surname, set: setSurname },
    gender: { get: gender, set: setGender },
    age: { get: age, set: setAge },

    // Parents
    fatherId: { get: fatherId, set: setFatherId },
    motherId: { get: motherId, set: setMotherId },
    resemblance: { get: resemblance, set: setResemblance },
    colorFather: { get: colorFather, set: setColorFather },
    colorMother: { get: colorMother, set: setColorMother },
    skinMix: { get: skinMix, set: setSkinMix },

    // Face
    eyesColor: { get: eyesColor, set: setEyesColor },
    eyesOpening: { get: eyesOpening, set: setEyesOpening },
    eyebrowsHeight: { get: eyebrowsHeight, set: setEyebrowsHeight },
    eyebrowsWidth: { get: eyebrowsWidth, set: setEyebrowsWidth },
    eyebrowsModel: { get: eyebrowsModel, set: setEyebrowsModel },
    eyebrowsColor: { get: eyebrowsColor, set: setEyebrowsColor },
    eyebrowsOpacity: { get: eyebrowsOpacity, set: setEyebrowsOpacity },

    noseWidth: { get: noseWidth, set: setNoseWidth },
    noseHeight: { get: noseHeight, set: setNoseHeight },
    noseLength: { get: noseLength, set: setNoseLength },
    noseBridge: { get: noseBridge, set: setNoseBridge },
    noseTip: { get: noseTip, set: setNoseTip },
    noseShift: { get: noseShift, set: setNoseShift },

    cheekboneHeight: { get: cheekboneHeight, set: setCheekboneHeight },
    cheekboneWidth: { get: cheekboneWidth, set: setCheekboneWidth },
    cheeksWidth: { get: cheeksWidth, set: setCheeksWidth },

    lips: { get: lips, set: setLips },
    jawWidth: { get: jawWidth, set: setJawWidth },
    jawHeight: { get: jawHeight, set: setJawHeight },

    chinLength: { get: chinLength, set: setChinLength },
    chinPosition: { get: chinPosition, set: setChinPosition },
    chinWidth: { get: chinWidth, set: setChinWidth },
    chinShape: { get: chinShape, set: setChinShape },
    neckWidth: { get: neckWidth, set: setNeckWidth },

    // Hair
    hairModel: { get: hairModel, set: setHairModel },
    firstHairColor: { get: firstHairColor, set: setFirstHairColor },
    secondHairColor: { get: secondHairColor, set: setSecondHairColor },

    beardModel: { get: beardModel, set: setBeardModel },
    beardColor: { get: beardColor, set: setBeardColor },
    beardOpacity: { get: beardOpacity, set: setBeardOpacity },

    chestModel: { get: chestModel, set: setChestModel },
    chestColor: { get: chestColor, set: setChestColor },
    chestOpacity: { get: chestOpacity, set: setChestOpacity },

    blushModel: { get: blushModel, set: setBlushModel },
    blushColor: { get: blushColor, set: setBlushColor },
    blushOpacity: { get: blushOpacity, set: setBlushOpacity },
    lipstickModel: { get: lipstickModel, set: setLipstickModel },
    lipstickColor: { get: lipstickColor, set: setLipstickColor },
    lipstickOpacity: { get: lipstickOpacity, set: setLipstickOpacity },
    blemishesModel: { get: blemishesModel, set: setBlemishesModel },
    blemishesOpacity: { get: blemishesOpacity, set: setBlemishesOpacity },
    ageingModel: { get: ageingModel, set: setAgeingModel },
    ageingOpacity: { get: ageingOpacity, set: setAgeingOpacity },
    complexionModel: { get: complexionModel, set: setComplexionModel },
    complexionOpacity: { get: complexionOpacity, set: setComplexionOpacity },
    sundamageModel: { get: sundamageModel, set: setSundamageModel },
    sundamageOpacity: { get: sundamageOpacity, set: setSundamageOpacity },
    frecklesModel: { get: frecklesModel, set: setFrecklesModel },
    frecklesOpacity: { get: frecklesOpacity, set: setFrecklesOpacity },
    makeupModel: { get: makeupModel, set: setMakeupModel },
    makeupOpacity: { get: makeupOpacity, set: setMakeupOpacity },
  };
}

export default useData;
