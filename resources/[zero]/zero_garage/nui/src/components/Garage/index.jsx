import * as S from "./styles";
import Input from "../Input";
import { FaCarSide, FaMotorcycle } from "react-icons/fa";
import { RiVipDiamondLine } from "react-icons/ri";
import { useCallback, useContext, useEffect, useMemo, useState } from "react";
import GarageContext from "../../contexts/GarageContext";
import ItemGarage from "../ItemGarage";
import useRequest from "../../hook/useRequest";

function Garage() {
  const [car, setCar] = useState({});
  const [imageError, setImageError] = useState(false);
  const [search, setSearch] = useState("");
  const [filter, setFilter] = useState("");
  const { garage, setGarage } = useContext(GarageContext);
  const { request } = useRequest();

  const closeGarage = useCallback(() => {
    setGarage({});
    request("close");
  }, [request, setGarage]);

  useEffect(() => {
    if (garage.cars.length > 0) {
      setCar(garage.cars[0]);
    }
  }, [garage]);

  useEffect(() => {
    setImageError(false);
  }, [car]);

  const filteredsCars = useMemo(() => {
    return garage.cars.filter(
      (item) =>
        item.name.toLowerCase().includes(search.toLowerCase()) &&
        item.type.toLowerCase().includes(filter.toLowerCase())
    );
  }, [garage, search, filter]);

  const handleSaveCar = useCallback(() => {
    request("saveVeh", {
      spawn: car.spawn,
    });
    closeGarage();
  }, [car, request, closeGarage]);

  const handleSaveNextCar = useCallback(() => {
    request("saveNextVeh");
    closeGarage();
  }, [request, closeGarage]);

  const handleUseCar = useCallback(() => {
    request("useVeh", {
      spawn: car.spawn,
    });
    closeGarage();
  }, [request, car, closeGarage]);

  const handleTestDrive = () => {
    request("testDrive", {
      spawn: car.spawn,
    });
    closeGarage();
  };

  const handleBuyCar = () => {
    request("buyCar", {
      spawn: car.spawn,
    });
    closeGarage();
  };

  return (
    <S.Container>
      <S.Left>
        <S.LeftHeader>
          <S.Title src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=810&height=282" />
          <Input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="input-search"
            placeholder="Pesquise pelo nome do carro..."
          />
        </S.LeftHeader>
        <S.Car>
          {car.name && (
            <>
              {!imageError ? (
                <S.CarImage
                  src={`http://189.0.88.222/zero_garage/${car.spawn}.png`}
                  onError={() => setImageError(true)}
                />
              ) : (
                <S.WrapIconCar>
                  {car.type === "car" && <FaCarSide />}
                  {car.type === "motocycle" && <FaMotorcycle />}
                  {car.type === "vip" && <RiVipDiamondLine />}
                </S.WrapIconCar>
              )}
              <S.CarTitle>{car.name}</S.CarTitle>
              <S.CarSubtitle>{car.maker}</S.CarSubtitle>
              <S.Stats>
                <S.ItemStats>
                  <S.StatsLabel>Motor</S.StatsLabel>
                  <S.ProgressBar>
                    <S.Progress progress={car.engine} />
                  </S.ProgressBar>
                </S.ItemStats>
                <S.ItemStats>
                  <S.StatsLabel>Freios</S.StatsLabel>
                  <S.ProgressBar>
                    <S.Progress progress={car.breaker} />
                  </S.ProgressBar>
                </S.ItemStats>
                <S.ItemStats>
                  <S.StatsLabel>Transmissão</S.StatsLabel>
                  <S.ProgressBar>
                    <S.Progress progress={car.transmission} />
                  </S.ProgressBar>
                </S.ItemStats>
                <S.ItemStats>
                  <S.StatsLabel>Suspensão</S.StatsLabel>
                  <S.ProgressBar>
                    <S.Progress progress={car.suspension} />
                  </S.ProgressBar>
                </S.ItemStats>
                {!garage.dealership && (
                  <>
                    <S.ItemStats>
                      <S.StatsLabel>Combustível</S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress progress={car.fuel} />
                      </S.ProgressBar>
                    </S.ItemStats>
                    <S.ItemStats>
                      <S.StatsLabel>Porta-malas</S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress progress={car.trunk} />
                      </S.ProgressBar>
                    </S.ItemStats>
                  </>
                )}
              </S.Stats>
              {garage.dealership && car.type !== "vip" && (
                <S.DealershipStatusList>
                  <S.DealershipStatus>
                    <S.DealerTitle>Estoque</S.DealerTitle>
                    <S.DealerValue>{car.stock}</S.DealerValue>
                  </S.DealershipStatus>
                  <S.DealershipStatus>
                    <S.DealerTitle>Preço</S.DealerTitle>
                    <S.DealerValue>R${car.price},00</S.DealerValue>
                  </S.DealershipStatus>
                </S.DealershipStatusList>
              )}
            </>
          )}
        </S.Car>
        <S.Actions>
          {garage.dealership && (
            <>
              <S.BtnAction onClick={handleTestDrive}>Teste Drive</S.BtnAction>
              {car.type !== "vip" && (
                <S.BtnAction className="active" onClick={handleBuyCar}>
                  Comprar
                </S.BtnAction>
              )}
            </>
          )}
          {!garage.dealership && (
            <>
              <S.BtnAction onClick={handleSaveNextCar}>
                Guardar próximo
              </S.BtnAction>
              <S.BtnAction onClick={handleSaveCar}>
                Guardar este carro
              </S.BtnAction>
              <S.BtnAction onClick={handleUseCar}>Retirar</S.BtnAction>
            </>
          )}
        </S.Actions>
      </S.Left>
      <S.Right>
        <S.RightHeader>
          <S.Filters>
            <S.CarFilter active={filter === ""} onClick={() => setFilter("")}>
              Todos
            </S.CarFilter>
            <S.CarFilter
              active={filter === "car"}
              onClick={() => setFilter("car")}
            >
              <FaCarSide />
            </S.CarFilter>
            <S.CarFilter
              active={filter === "motocycle"}
              onClick={() => setFilter("motocycle")}
            >
              <FaMotorcycle />
            </S.CarFilter>
            <S.CarFilter
              active={filter === "vip"}
              onClick={() => setFilter("vip")}
            >
              <RiVipDiamondLine />
            </S.CarFilter>
          </S.Filters>
          <S.CloseButton onClick={closeGarage}>Esc</S.CloseButton>
        </S.RightHeader>
        <S.WrapCarList>
          <S.CarsList>
            {filteredsCars.length > 0 ? (
              <>
                {filteredsCars.map((item) => (
                  <ItemGarage key={item.name} item={item} setCar={setCar} />
                ))}
              </>
            ) : (
              <S.EmptyCarList>Veículos não encontrados!</S.EmptyCarList>
            )}
          </S.CarsList>
        </S.WrapCarList>
      </S.Right>
    </S.Container>
  );
}

export default Garage;
