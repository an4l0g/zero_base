import React, { useState, useEffect, useContext } from "react";
import {
  FiPhone,
  FiUserPlus,
  FiClipboard,
  FiLock,
  FiLoader,
  FiPlus,
  FiTrendingUp,
  FiTrendingDown,
  FiX,
  FiUser,
} from "react-icons/fi";
import Structure from "../Structure";
import * as S from "./styles";
import * as GS from "../../styles";
import { MemberDTO } from "../../DTOS/Members";
import { UserContext } from "../../contexts/UserContext";
import api from "../../services/api";
import { toast } from "react-toastify";
import { ModalContext } from "../../contexts/ModalContext";
import useMembersAmount from "../../hooks/useMembersAmount";
import useUserRole from "../../hooks/useUserRole";

const Membros = () => {
  const [search, setSearch] = useState("");
  const [members, setMembers] = useState<MemberDTO[]>([] as MemberDTO[]);
  const { user } = useContext(UserContext);
  const [currentMember, setCurrentMember] = useState<MemberDTO>(
    {} as MemberDTO
  );
  const { setModal } = useContext(ModalContext);
  const { getMembersAmount } = useMembersAmount();
  const { getPermission } = useUserRole();

  const handleGetAllMembers = async () => {
    const allMembers = (
      await api.post("/getAllMembers", {
        fac: user.fac,
      })
    ).data;

    setMembers(JSON.parse(allMembers) as any);
    getMembersAmount();
  };

  useEffect(() => {
    handleGetAllMembers();
  }, []);

  const handleSearchSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    setCurrentMember({} as MemberDTO);

    const member = (
      await api.post(
        "/searchUser",
        JSON.stringify({
          user_id: search,
        })
      )
    ).data;

    setCurrentMember(JSON.parse(member) as any);
  };

  const handleAdmitir = async () => {
    setModal({
      text: `Deseja realmente contratar o passaporte ${currentMember.user_id}?`,
      actionConfirm: async () => {
        const response = JSON.parse(
          (
            await api.post(
              "/admit",
              JSON.stringify({
                fac: user.fac,
                user_id: currentMember.user_id,
              })
            )
          ).data
        );

        if (response.result === "success") {
          toast.success(response.message);
          handleGetAllMembers();
        }
        if (response.result === "error") toast.error(response.message);
      },
    });
  };

  const handlePromover = () => {
    setModal({
      text: `Deseja realmente promover o passaporte ${currentMember.user_id}?`,
      actionConfirm: async () => {
        const response = JSON.parse(
          (
            await api.post(
              "/updateRole",
              JSON.stringify({
                user_id: currentMember.user_id,
                fac: user.fac,
                method: "promote",
              })
            )
          ).data
        );
        handleGetAllMembers();
        if (response.result === "success") {
          toast.success(response.message);
        }
        if (response.result === "error") toast.error(response.message);
      },
    });
  };
  const handleRebaixar = () => {
    setModal({
      text: `Deseja realmente promover o passaporte ${currentMember.user_id}?`,
      actionConfirm: async () => {
        const response = JSON.parse(
          (
            await api.post(
              "/updateRole",
              JSON.stringify({
                user_id: currentMember.user_id,
                fac: user.fac,
                method: "downgrade",
              })
            )
          ).data
        );
        handleGetAllMembers();
        if (response.result === "success") {
          toast.success(response.message);
        }
        if (response.result === "error") toast.error(response.message);
      },
    });
  };
  const handleDemitir = () => {
    setModal({
      text: `Deseja realmente demitir o passaporte ${currentMember.user_id}?`,
      actionConfirm: async () => {
        const response = JSON.parse(
          (
            await api.post(
              "/dismiss",
              JSON.stringify({
                user_id: currentMember.user_id,
                fac: user.fac,
              })
            )
          ).data
        );
        handleGetAllMembers();
        if (response.result === "success") {
          toast.success(response.message);
        }
        if (response.result === "error") toast.error(response.message);
      },
    });
  };

  const orderByRole = () => {
    return members.sort((a, b) => {
      if (a.role > b.role) return 1;
      if (a.role < b.role) return -1;
      else return 0;
    });
  };

  return (
    <Structure>
      <S.Container>
        {getPermission() !== "Membro" && (
          <>
            <GS.Side>
              <S.FormCard>
                <S.Form onSubmit={handleSearchSubmit}>
                  <GS.Title>
                    <FiUserPlus /> Formulário de admissão
                  </GS.Title>
                  <S.FormInput
                    placeholder="Passaporte"
                    value={search}
                    type="number"
                    onChange={(e) => setSearch(e.target.value)}
                  />
                  {currentMember.name && (
                    <>
                      <GS.Divider />
                      <S.InfoUser>
                        <S.ItemInfoUser>
                          <b>Passaporte:</b> {currentMember.user_id}
                        </S.ItemInfoUser>
                        <S.ItemInfoUser>
                          <b>Name:</b> {currentMember.name}
                        </S.ItemInfoUser>
                        <S.ItemInfoUser>
                          <b>RG:</b> {currentMember.rg}
                        </S.ItemInfoUser>
                        <S.ItemInfoUser>
                          <b>Telefone:</b> {currentMember.phone}
                        </S.ItemInfoUser>
                        <S.ItemInfoUser>
                          <b>Idade:</b> {currentMember.age} anos
                        </S.ItemInfoUser>
                      </S.InfoUser>
                    </>
                  )}
                </S.Form>
              </S.FormCard>
              <GS.ActionButton
                onClick={handleAdmitir}
                type="button"
                disabled={currentMember.name ? false : true}
                className="success"
              >
                <FiPlus />
                Admitir
              </GS.ActionButton>
              {getPermission() === "Lider" && (
                <>
                  <GS.ActionButton
                    onClick={handlePromover}
                    type="button"
                    disabled={currentMember.name ? false : true}
                    className="normal"
                  >
                    <FiTrendingUp />
                    Promover
                  </GS.ActionButton>
                  <GS.ActionButton
                    onClick={handleRebaixar}
                    type="button"
                    disabled={currentMember.name ? false : true}
                    className="warn"
                  >
                    <FiTrendingDown /> Rebaixar
                  </GS.ActionButton>
                </>
              )}
              <GS.ActionButton
                onClick={handleDemitir}
                type="button"
                disabled={currentMember.name ? false : true}
                className="error"
              >
                <FiX />
                Demitir
              </GS.ActionButton>
            </GS.Side>
          </>
        )}
        <GS.Table>
          <GS.Row className="headRow">
            <GS.Column flex={1}>
              <FiUser />
            </GS.Column>
            <GS.Column flex={3}>
              <FiClipboard /> Nome
            </GS.Column>
            <GS.Column flex={2}>
              <FiLock /> Cargo
            </GS.Column>
            <GS.Column flex={2}>
              <FiPhone /> Telefone
            </GS.Column>
            <GS.Column flex={2}>
              <FiLoader /> Status
            </GS.Column>
          </GS.Row>
          {orderByRole().map((item) => (
            <GS.Row key={item.name} onClick={() => setCurrentMember(item)}>
              <GS.Column flex={1}>{item.user_id}</GS.Column>
              <GS.Column flex={3}>{item.name}</GS.Column>
              <GS.Column flex={2}>{item.role.toUpperCase()}</GS.Column>
              <GS.Column flex={2}>{item.phone}</GS.Column>
              <GS.Column flex={2}>
                {item.status ? "Online" : "Offline"}
              </GS.Column>
            </GS.Row>
          ))}
        </GS.Table>
      </S.Container>
    </Structure>
  );
};

export default Membros;
