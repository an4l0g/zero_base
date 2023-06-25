import { useContext, useRef, useState } from "react";
import * as S from "../GenericalStyles";
import Slider from "../Slider";
import ColorPicker from "../ColorPicker";

import { BsScissors, BsCheckCircle } from "react-icons/bs";
import { MdFace } from "react-icons/md";
import { IoMdColorPalette } from "react-icons/io";
import AppearanceContext from "../../contexts/AppearanceContext";

function BarberShop() {
  const headerListRef = useRef();
  const { appearance } = useContext(AppearanceContext);
  const [rotation, setRotation] = useState(0);
  const [customization, setCustomization] = useState(false);
  const [color1, setColor1] = useState("");
  const [color2, setColor2] = useState("");
  const [opacity, setOpacity] = useState(0);

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
                  {Object.keys(appearance.barbershop.drawables).map(
                    (item, index) => (
                      <S.TypeItem key={item}>
                        {/* {item} */}
                        <S.TypeImage
                          src={`http://localhost/zero_appearance/barbershop/${item}.png`}
                        />
                      </S.TypeItem>
                    )
                  )}
                </S.TypeList>
                <S.RightWrap>
                  <S.OptionsListWrap>
                    <S.OptionsList>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
                      <S.OptionItem></S.OptionItem>
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
                    <BsCheckCircle /> Finalizar
                  </S.BtnAction>
                </S.WrapAction>
              </S.Actions>
            </S.Content>
          </S.Container>
          {customization && (
            <S.Customization>
              <ColorPicker
                label="Cor 1"
                value={color1}
                setValue={(val) => setColor1(val)}
              />
              <ColorPicker
                label="Cor 2"
                value={color2}
                setValue={(val) => setColor2(val)}
              />
              <Slider
                label="Opacidade"
                value={opacity}
                setValue={(val) => setOpacity(val)}
                min={0}
                max={0.99}
                step={0.01}
                ruler={true}
              />
            </S.Customization>
          )}
        </>
      )}
    </>
  );
}

export default BarberShop;
