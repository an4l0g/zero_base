import { useCallback, useEffect, useMemo, useRef } from "react";
import useInteractions from "../../hooks/useInteractions";
import * as S from "./styles";
import { BiChevronLeft } from "react-icons/bi";
import { AiFillStar, AiOutlineStar } from "react-icons/ai";
import useRequest from "../../hooks/useRequest";

function Dynamic() {
  const searchRef = useRef();
  const {
    search,
    setSearch,
    category,
    setCategory,
    interactions,
    handleClickInteraction,
    isFavorite,
  } = useInteractions();
  const { request } = useRequest();

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

  const handleToggleFavorite = (action, value) => {
    let favoriteAction = action;
    if (value) {
      favoriteAction = favoriteAction + ":" + value;
    }

    if (isFavorite(action, value)) {
      request("deleteFavorite", { action: favoriteAction });
    } else {
      request("setFavorite", { action: favoriteAction });
    }
  };

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
              <S.Item key={interaction.title}>
                <S.ItemDescription
                  onClick={() => handleClickInteraction(interaction)}
                >
                  {interaction.icon}
                  {interaction.title}
                </S.ItemDescription>
                {interaction.type !== "category" && (
                  <S.FavButton
                    onClick={() =>
                      handleToggleFavorite(
                        interaction.action,
                        interaction.value
                      )
                    }
                  >
                    {isFavorite(interaction.action, interaction.value) ? (
                      <AiFillStar />
                    ) : (
                      <AiOutlineStar />
                    )}
                  </S.FavButton>
                )}
              </S.Item>
            ))}
          </>
        ) : (
          <S.EmptyFeedback>Nada foi encontrado!</S.EmptyFeedback>
        )}
      </S.ActionList>
    </S.Container>
  );
}

export default Dynamic;
