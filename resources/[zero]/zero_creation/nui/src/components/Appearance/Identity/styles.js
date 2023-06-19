import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.5)};
    background-image: linear-gradient(
      to bottom right,
      ${theme.colors.dark(0.8)},
      ${theme.colors.primary(0.2)}
    );
    flex: 1;
    padding: 2rem 2rem 3rem;
    border-radius: 5px;
    border: 2px solid ${theme.colors.primary()};
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1.5rem;
  `}
`;
