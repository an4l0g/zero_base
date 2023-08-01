import styled, { css } from "styled-components";
import { theme } from "../../styles";
import BgLoginFac from "../../assets/bg_login_fac.png";
import BgLoginJob from "../../assets/bg_login_Job.png";

type ContainerProps = {
  facType: "fac" | "job";
};

export const Container = styled.section<ContainerProps>`
  ${({ facType }) => css`
    ${facType === "fac"
      ? css`
          background-image: url(${BgLoginFac});
        `
      : css`
          background-image: url(${BgLoginJob});
        `}
  `}

  background-size: cover;
  background-position: center top;
  width: 100%;
  height: 100%;
`;

export const Filter = styled.div`
  background-color: ${theme.colors.primary_opacity(0.3)};
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
`;

export const BtnLogin = styled.button`
  background-color: ${theme.colors.secondary};
  width: 350px;
  padding: 50px 10px;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
  border: 3px solid ${theme.colors.secondary};
  cursor: pointer;
  transition: all 0.5s;

  &:hover {
    background-color: #252525;
  }
`;

export const Title = styled.h1`
  font-size: 22px;
  letter-spacing: 2px;
  color: white;
  font-weight: bold;

  & > b {
    color: ${theme.colors.primary};
  }
`;

export const WrapLogo = styled.div`
  background-color: rgba(0, 0, 0, 0.5);
  padding: 20px;
  border-radius: 50%;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
`;

export const Logo = styled.img`
  width: 64px;
  height: auto;
`;
