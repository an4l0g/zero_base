import { useCallback, useEffect, useMemo, useRef } from "react";
import useInteractions from "../../hooks/useInteractions";
import * as S from "./styles";
import { BiChevronLeft } from "react-icons/bi";

function Dynamic() {
  const searchRef = useRef();
  const {
    search,
    setSearch,
    category,
    setCategory,
    interactions,
    handleClickInteraction,
  } = useInteractions();

  useEffect(() => {
    searchRef.current.focus();
  }, []);

  const filteredInteractions = useMemo(() => {
    return interactions.filter((item) => {
      if (search !== "") {
        return item.title.toLowerCase().includes(search.toLowerCase());
      } else {
        return item.category.includes(
          category.length > 0 ? category[category.length - 1] : "main"
        );
      }
    });
  }, [interactions, search, category]);

  const handleBackButton = useCallback(() => {
    setCategory((old) => {
      let newCategory = [...old];
      newCategory.pop();

      return newCategory;
    });
  }, [setCategory]);

  return (
    <S.Container>
      <S.Title>
        <span>[ZERO]</span> Interações
      </S.Title>
      <S.Header>
        {category.length > 1 && (
          <S.BackButton onClick={handleBackButton}>
            <BiChevronLeft />
          </S.BackButton>
        )}
        <S.Search
          ref={searchRef}
          placeholder="Pesquisar por..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />
      </S.Header>
      <S.ActionList>
        {filteredInteractions.length > 0 ? (
          <>
            {filteredInteractions.map((interaction) => (
              <S.Item
                key={interaction.title}
                onClick={() => handleClickInteraction(interaction)}
              >
                {interaction.icon}
                {interaction.title}
              </S.Item>
            ))}
          </>
        ) : (
          <S.EmptyFeedback>
            Nada foi encontrado <strong>!</strong>
          </S.EmptyFeedback>
        )}
      </S.ActionList>
    </S.Container>
  );
}

export default Dynamic;
