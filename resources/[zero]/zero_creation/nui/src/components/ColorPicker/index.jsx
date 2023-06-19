import { useState } from "react";
import * as S from "./styles";
import Colors from "./colors.json";

function ColorPicker({ label, value, setValue }) {
  const [opened, setOpened] = useState(false);

  const handleChange = (option) => {
    setValue(option);
    setOpened(false);
  };

  return (
    <S.Container>
      <S.Label>{label}</S.Label>
      <S.Picker>
        <S.Placeholder
          onClick={() => setOpened((old) => !old)}
          bgColor={Colors[value]}
        ></S.Placeholder>
        {opened && (
          <>
            <S.Backdrop onClick={() => setOpened(false)} />
            <S.Colors>
              <>
                {Colors.map((option, index) => (
                  <S.Option
                    key={option}
                    onClick={() => handleChange(index)}
                    bgColor={option}
                    active={index === value}
                  />
                ))}
              </>
            </S.Colors>
          </>
        )}
      </S.Picker>
    </S.Container>
  );
}

export default ColorPicker;
