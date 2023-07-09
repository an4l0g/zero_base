import { useCallback, useContext, useEffect, useState } from "react";
import * as S from "./styles";

import { AiOutlineClose } from "react-icons/ai";
import PainelContext from "../../contexts/PainelContext";
import useRequest from "../../hooks/useRequest";
import DetailsContext from "../../contexts/DetailsContext";

function Details() {
  const { request } = useRequest();
  const { painel, setPainel } = useContext(PainelContext);
  const { currentService } = painel;
  const [price, setPrice] = useState("");
  const [service, setService] = useState("t");
  const [description, setDescription] = useState("");
  const { details, setDetails } = useContext(DetailsContext);

  useEffect(() => {
    if (details?.patient_id) {
      setPrice(details.total_price);
      setService(details.service);
      setDescription(details.description);
    } else {
      if (service !== "m") {
        setPrice(painel.prices[service]);
      } else {
        setPrice("");
      }
    }
  }, [service, setPrice, painel, details]);

  const handleCancelService = () => {
    if (details.patient_id) {
      setDetails({});
    } else {
      request("cancelService");
      setPainel({});
    }
  };

  const handleRegisterService = useCallback(() => {
    request("registerService", {
      service_type: service,
      patient_id: currentService.user_id,
      total_price: price,
      request: currentService.request,
      description,
    });
  }, [price, request, service, currentService, description]);

  return (
    <>
      {(painel.currentService.user_id || details.patient_id !== null) && (
        <S.Details>
          <S.BackImage src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=810&height=282" />
          <S.Content>
            <S.CloseButton onClick={handleCancelService}>
              <AiOutlineClose />
            </S.CloseButton>
            <S.Form>
              <S.Title>
                <span>#{currentService?.user_id ?? details.patient_id}</span> -{" "}
                {currentService.firstname} {currentService.lastname}
              </S.Title>
              <S.Group>
                <S.Input>
                  <S.Label>Tipo de atendimento:</S.Label>
                  <S.Select
                    value={service}
                    onChange={(e) => setService(e.target.value)}
                  >
                    <option value="t">Tratamento</option>
                    <option value="v">Vacina</option>
                    <option value="s">Retirada de sangue</option>
                    <option value="c">Cirurgia Plástica</option>
                    <option value="m">Medicamento</option>
                  </S.Select>
                </S.Input>
                <S.Input>
                  <S.Label>Valor do atendimento:</S.Label>
                  <S.Price
                    value={price}
                    disabled={service === "c" || service === "t"}
                    type="number"
                    onChange={(e) => setPrice(e.target.value)}
                    placeholder="Valor"
                  />
                </S.Input>
              </S.Group>
              <S.Group>
                <S.Input>
                  <S.Label>Detalhes de atendimento:</S.Label>
                  <S.Textarea
                    value={description}
                    onChange={(e) => setDescription(e.target.value)}
                    rows={5}
                  ></S.Textarea>
                </S.Input>
                <S.Input>
                  <S.Label>Solicitação do paciente:</S.Label>
                  <S.Textarea
                    value={painel.currentService.request}
                    disabled
                    rows={5}
                  ></S.Textarea>
                </S.Input>
              </S.Group>
              <S.Group>
                <S.Button onClick={handleRegisterService}>
                  Registrar Atendimento
                </S.Button>
                <S.Datetime>22/04/2022 às 20h00</S.Datetime>
              </S.Group>
            </S.Form>
            )}
          </S.Content>
        </S.Details>
      )}
    </>
  );
}

export default Details;
