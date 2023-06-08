import { createGlobalStyle, css } from "styled-components";

export default createGlobalStyle`
    ${({ theme }) => css`
      * {
        box-sizing: border-box;
        padding: 0;
        margin: 0;
      }

      body {
        width: 100vw;
        height: 100vh;
        padding: 0;
        margin: 0;
        font-family: "Geologica", sans-serif;
        letter-spacing: 1px;
      }

      h1 {
        font-family: "Geologica", sans-serif;
      }

      *,
      input,
      button,
      textarea,
      select {
        font-family: "Geologica", sans-serif;
      }

      *::-webkit-scrollbar {
        width: 3px;
      }

      /* Track */
      *::-webkit-scrollbar-track {
        background: transparent;
        border-radius: 3px;
      }

      /* Handle */
      *::-webkit-scrollbar-thumb {
        background-image: linear-gradient(
          to bottom,
          ${theme.colors.secondary(0.3)},
          transparent
        );
        border-radius: 100px;
      }
    `}
`;
