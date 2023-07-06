import { useMemo } from "react";
import * as S from "./styles";
import { BiMessageDetail } from "react-icons/bi";
import { FaChevronLeft, FaChevronRight } from "react-icons/fa";

function Table({ headRow, data, search, detail = false, handleShowDetail }) {
  const formattedData = useMemo(() => {
    let formattedItems = [];
    data.map((row) => {
      formattedItems = [
        ...formattedItems,
        Object.keys(row).map((item) => {
          return row[item];
        }),
      ];
    });

    return formattedItems.filter((row) => {
      let isValidated = false;
      row.map((column) => {
        if (column.toString().toLowerCase().includes(search.toLowerCase())) {
          isValidated = true;
        }
      });
      return isValidated;
    });
  }, [data, search]);

  return (
    <S.WrapTable>
      <S.Table>
        <S.Row className="head">
          {headRow.map((item) => (
            <S.Td key={item.title}>
              {item.icon} {item.title}
            </S.Td>
          ))}
          {detail && <S.Td className="detail"></S.Td>}
        </S.Row>
        {formattedData.length > 0 ? (
          <>
            {formattedData.map((row, index) => (
              <S.Row key={index}>
                {row.map((column) => (
                  <S.Td key={column}>{column}</S.Td>
                ))}
                {detail && (
                  <S.Td className="detail">
                    <S.ButtonAction onClick={() => handleShowDetail(row)}>
                      <BiMessageDetail />
                    </S.ButtonAction>
                  </S.Td>
                )}
              </S.Row>
            ))}
          </>
        ) : (
          <S.EmptyFeedback>Nenhum resultado foi encontrado.</S.EmptyFeedback>
        )}
      </S.Table>
      <S.Pagination>
        <S.ButtonPagination>
          <FaChevronLeft />
        </S.ButtonPagination>
        <S.IndicatorPagination>1/2</S.IndicatorPagination>
        <S.ButtonPagination>
          <FaChevronRight />
        </S.ButtonPagination>
      </S.Pagination>
    </S.WrapTable>
  );
}

export default Table;
