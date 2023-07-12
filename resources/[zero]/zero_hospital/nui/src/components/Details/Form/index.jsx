import { useCallback, useContext, useEffect, useState } from "react";
import * as S from "../styles";
import useRequest from "../../../hooks/useRequest";
import PainelContext from "../../../contexts/PainelContext";
import { formatDate } from "../../../utils";
import Services from "../../../enums/services.json";

function Form({ data, isDetails }) {
  const { request } = useRequest();
  const { painel } = useContext(PainelContext);
  const [price, setPrice] = useState("");
  const [service, setService] = useState("t");
  const [description, setDescription] = useState("");

  useEffect(() => {
    if (data.total_price) {
      setPrice(data.total_price);
    }
    setService(data?.service_type ?? "t");
    setDescription(data?.description ?? "");
  }, [setPrice, painel, data]);

  useEffect(() => {
    if (!data?.total_price) {
      if (service !== "m") {
        setPrice(painel.prices[service]);
      } else {
        setPrice("");
      }
    }
  }, [service, painel, setPrice, data]);

  const handleRegisterService = useCallback(() => {
    request("registerService", {
      service_type: service,
      patient_id: data.patient_id,
      total_price: price,
      request: data.request,
      description,
    });
  }, [price, request, service, description, data]);

  return (
    <S.Form>
      <S.Title>
        <span>#{data.patient_id}</span> - {data.patient_name}
      </S.Title>
      <S.Group>
        <S.Input>
          <S.Label>Tipo de atendimento:</S.Label>
          <S.Select
            value={service}
            onChange={(e) => setService(e.target.value)}
            disabled={isDetails}
          >
            {Object.keys(Services).map((service) => (
              <option value={service}>{Services[service]}</option>
            ))}
          </S.Select>
        </S.Input>
        <S.Input>
          <S.Label>Valor do atendimento:</S.Label>
          <S.Price
            value={price}
            disabled={service === "c" || service === "t" || isDetails}
            type={data.total_price ? "text" : "number"}
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
            disabled={isDetails}
            rows={5}
          ></S.Textarea>
        </S.Input>
        <S.Input>
          <S.Label>Solicitação do paciente:</S.Label>
          <S.Textarea
            value={data?.request ?? ""}
            disabled={isDetails}
            rows={5}
          ></S.Textarea>
        </S.Input>
      </S.Group>
      <S.Group>
        {!isDetails && (
          <S.Button onClick={handleRegisterService}>
            Registrar Atendimento
          </S.Button>
        )}
        <S.Datetime>{data?.service_date ?? formatDate(new Date())}</S.Datetime>
      </S.Group>
    </S.Form>
  );
}

export default Form;
