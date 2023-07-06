import Header from "../Header";
import Menu from "../Menu";
import Table from "../Table";
import * as S from "./styles";

import { PiIdentificationBadge } from "react-icons/pi";
import { MdMan2 } from "react-icons/md";
import { CiMedicalCross } from "react-icons/ci";
import { BiDollar } from "react-icons/bi";
import { useState } from "react";
import Details from "../Details";

function Painel() {
  const [search, setSearch] = useState("");

  return (
    <S.Container>
      <S.BackgroundImage src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=994&height=346" />
      <S.Content>
        {/* <Details /> */}
        <Header search={search} setSearch={setSearch} />
        <S.Body>
          <Menu />
          <Table
            search={search}
            headRow={[
              { icon: <PiIdentificationBadge />, title: "Id. Paciente" },
              { icon: <MdMan2 />, title: "Paciente" },
              { icon: <CiMedicalCross />, title: "Médico" },
              { icon: <BiDollar />, title: "Valor" },
            ]}
            detail={true}
            data={[
              {
                user_id: 1,
                pacient_name: "Paciente 1",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 2,
                pacient_name: "Paciente 2",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 3,
                pacient_name: "Paciente 3",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 1,
                pacient_name: "Paciente 1",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 2,
                pacient_name: "Paciente 2",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 3,
                pacient_name: "Paciente 3",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 1,
                pacient_name: "Paciente 1",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 2,
                pacient_name: "Paciente 2",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 3,
                pacient_name: "Paciente 3",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 1,
                pacient_name: "Paciente 1",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 2,
                pacient_name: "Paciente 2",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
              {
                user_id: 3,
                pacient_name: "Paciente 3",
                medic: "Ashley Papalombo",
                value: "R$123.321",
              },
            ]}
          />
        </S.Body>
      </S.Content>
    </S.Container>
  );
}

export default Painel;
