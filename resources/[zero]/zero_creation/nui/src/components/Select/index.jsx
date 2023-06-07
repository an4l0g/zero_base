import { useCallback, useState } from "react";
import * as S from "./styles";
import { AiOutlineDown, AiOutlineUp } from "react-icons/ai";

const Select = ({ value = "", placeholder, options = [], onChange }) => {
  const [search, setSearch] = useState("");
  const [opened, setOpened] = useState(false);

  const filteredOptions = useCallback(() => {
    return options.filter((item) =>
      item.toLowerCase().includes(search.toLowerCase())
    );
  }, [options, search]);

  const handleChange = useCallback(
    (option) => {
      setSearch("");
      setOpened(false);
      onChange(option);
    },
    [onChange, setOpened]
  );

  return (
    <S.Container>
      <S.Select>
        <S.Placeholder onClick={() => setOpened((old) => !old)}>
          {value !== "" ? value : placeholder}
          {opened ? <AiOutlineUp /> : <AiOutlineDown />}
        </S.Placeholder>
        {opened && (
          <>
            <S.Backdrop onClick={() => setOpened(false)} />
            <S.Options>
              <S.Input
                placeholder="Pesquisar..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
              />
              {filteredOptions().length > 0 ? (
                <>
                  {filteredOptions().map((option) => (
                    <S.Option key={option} onClick={() => handleChange(option)}>
                      {option}
                    </S.Option>
                  ))}
                </>
              ) : (
                <S.Empty>Sem resultado</S.Empty>
              )}
            </S.Options>
          </>
        )}
      </S.Select>
    </S.Container>
  );
};

export default Select;
