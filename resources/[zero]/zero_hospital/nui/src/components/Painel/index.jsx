import Header from "../Header";
import Menu from "../Menu";
import Table from "../Table";
import * as S from "./styles";

import { PiIdentificationBadge } from "react-icons/pi";
import { MdMan2 } from "react-icons/md";
import { CiMedicalCross } from "react-icons/ci";
import { BiDollar } from "react-icons/bi";
import { useContext, useState } from "react";
import Details from "../Details";
import PainelContext from "../../contexts/PainelContext";
import { formatDate, intToReal } from "../../utils";
import DetailsContext from "../../contexts/DetailsContext";

function Painel() {
  const { painel } = useContext(PainelContext);
  const { setDetails } = useContext(DetailsContext);
  const [search, setSearch] = useState("");

  return (
    <S.Container>
      <S.BackgroundImage src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=994&height=346" />
      <S.Content>
        <Details />
        <Header search={search} setSearch={setSearch} />
        <S.Body>
          <Menu />
          <Table
            search={search}
            headRow={[
              { icon: <MdMan2 />, title: "Paciente" },
              { icon: <CiMedicalCross />, title: "Médico" },
              { icon: <BiDollar />, title: "Valor" },
              { icon: <PiIdentificationBadge />, title: "Data" },
            ]}
            detail={true}
            data={painel.dayServices.map((service) => ({
              patient_name: service.patient_name,
              doctor_name: service.doctor_name,
              total_price: intToReal(service.total_price),
              service_date: formatDate(new Date(service.service_date)),
            }))}
            handleShowDetail={(data) => setDetails(data)}
          />
        </S.Body>
      </S.Content>
    </S.Container>
  );
}

export default Painel;
