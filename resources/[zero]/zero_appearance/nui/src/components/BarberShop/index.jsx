import { useContext, useEffect, useMemo, useRef, useState } from "react";
import * as S from "../GenericalStyles";
import Slider from "../Slider";
import ColorPicker from "../ColorPicker";
import Types from "./types.json";

import { BsScissors } from "react-icons/bs";
import { MdFace, MdAttachMoney } from "react-icons/md";
import { IoMdColorPalette } from "react-icons/io";
import AppearanceContext from "../../contexts/AppearanceContext";
import ResultContext from "../../contexts/ResultContext";
import Item from "../Item";
import useBarbershop from "../../hooks/useBarbershop";

function BarberShop() {
  const headerListRef = useRef();
  const firstRender = useRef(true);
  const { appearance } = useContext(AppearanceContext);
  const { result } = useContext(ResultContext);
  const { handleSetResult, calculateTotal } = useBarbershop();
  const [rotation, setRotation] = useState(0);
  const [customization, setCustomization] = useState(false);
  const [currentModel, setCurrentModel] = useState(0);
  const [mainColor, setMainColor] = useState("");
  const [secondaryColor, setSecondaryColor] = useState("");
  const [opacity, setOpacity] = useState(0);
  const [customizationType, setCustomizationType] = useState("");
  const [indexType, setIndexType] = useState(0);
  const [limit, setLimit] = useState(0);

  const renderItems = useMemo(() => {
    return new Array(limit).fill(null);
  }, [limit]);

  const handleChangeType = (index, customLimit) => {
    setCustomizationType(Types[index].path);
    setIndexType(index);
    setLimit(customLimit);
  };

  useEffect(() => {
    if (customizationType !== "" && firstRender.current) {
      firstRender.current = false;
      setCurrentModel(result.current[customizationType].model);
    }
  }, [setCurrentModel, customizationType, result]);

  useEffect(() => {
    handleSetResult(indexType, {
      model: currentModel,
      opacity,
      main_color: mainColor,
      secondary_color: secondaryColor,
    });
  }, [
    indexType,
    currentModel,
    opacity,
    mainColor,
    secondaryColor,
    handleSetResult,
  ]);

  return (
    <>
      {appearance.barbershop && (
        <>
          <S.Container>
            <S.FloatLogo src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=810&height=282" />
            <S.Content>
              <S.Header>
                <S.HeaderDivider position="flex-start">
                  <S.Logo src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=100&height=35" />
                </S.HeaderDivider>
                <S.HeaderDivider position="center">
                  <S.Title>
                    <S.WrapIcon>
                      <BsScissors />
                    </S.WrapIcon>
                    Barbearia
                  </S.Title>
                </S.HeaderDivider>
                <S.HeaderDivider position="flex-end">
                  <S.PovButton>
                    <MdFace />
                  </S.PovButton>
                </S.HeaderDivider>
              </S.Header>
              <S.Shop>
                <S.TypeList ref={headerListRef}>
                  {appearance.barbershop.drawables.map((item, index) => (
                    <S.TypeItem
                      // key={Object.keys(item)[0]}
                      onClick={() =>
                        handleChangeType(index, item[Types[index].path])
                      }
                    >
                      <S.TypeImage
                        src={`http://189.0.88.222/zero_appearance/barbershop/${index}.png`}
                      />
                      <S.TypeTitle>{Types[index].title}</S.TypeTitle>
                    </S.TypeItem>
                  ))}
                </S.TypeList>
                <S.RightWrap>
                  <S.OptionsListWrap>
                    <S.OptionsList>
                      {renderItems.map((_, index) => (
                        <Item
                          key={index}
                          index={index}
                          className={
                            result.current[Types[indexType].path].model ===
                            index
                              ? "active"
                              : ""
                          }
                          customizationType={customizationType}
                          handleClick={() => {
                            setCurrentModel(index);
                          }}
                        />
                      ))}
                    </S.OptionsList>
                  </S.OptionsListWrap>
                </S.RightWrap>
              </S.Shop>
              <S.Actions>
                <S.WrapAction>
                  <Slider
                    label="Rotação"
                    value={rotation}
                    setValue={(val) => setRotation(val)}
                    min={0}
                    max={360}
                    step={1}
                    ruler={true}
                  />
                </S.WrapAction>
                <S.WrapAction>
                  <S.CustomButton
                    onClick={() => setCustomization((old) => !old)}
                    customization={customization}
                  >
                    <IoMdColorPalette />
                  </S.CustomButton>
                  <S.BtnAction>
                    <MdAttachMoney /> {calculateTotal}
                  </S.BtnAction>
                </S.WrapAction>
              </S.Actions>
            </S.Content>
          </S.Container>
          {customization && (
            <S.Customization>
              {Types[indexType].main_color && (
                <ColorPicker
                  label="Cor 1"
                  value={mainColor}
                  setValue={(val) => setMainColor(val)}
                />
              )}
              {Types[indexType].secondary_color && (
                <ColorPicker
                  label="Cor 2"
                  value={secondaryColor}
                  setValue={(val) => setSecondaryColor(val)}
                />
              )}
              {Types[indexType].opacity && (
                <Slider
                  label="Opacidade"
                  value={opacity}
                  setValue={(val) => setOpacity(val)}
                  min={0}
                  max={0.99}
                  step={0.01}
                  ruler={true}
                />
              )}
            </S.Customization>
          )}
        </>
      )}
    </>
  );
}

export default BarberShop;
