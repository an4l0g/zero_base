import { useCallback, useContext, useEffect, useState } from "react";
import * as S from "./styles";
import Input from "../Input";
import useRequest from "../../hooks/useRequest";
import ProductionContext from "../../contexts/ProductionContext";

function Production({ data }) {
  const { setProduction } = useContext(ProductionContext);
  const [product, setProduct] = useState({});
  const [productIndex, setProductIndex] = useState("");
  const [amount, setAmount] = useState(0);
  const [blockProduction, setBlockProduction] = useState(false);
  const { request } = useRequest();

  useEffect(() => {
    setAmount(product.min_amount);
  }, [product]);

  useEffect(() => {
    if (amount !== "") {
      if (amount < product.min_amount) setAmount(product.min_amount);
      if (amount > product.max_amount) setAmount(product.max_amount);
      setBlockProduction(false);
    } else {
      setBlockProduction(true);
    }
  }, [amount, setAmount, product]);

  const handleProduction = useCallback(() => {
    request("production", {
      index: productIndex,
      amount,
      type: data.type,
    });
    request("close");
    setProduction({});
  }, [request, productIndex, amount, data]);

  const handleSelectProduct = (product) => {
    setProduct(data.products[product]);
    setProductIndex(product);
  };

  return (
    <S.Container>
      <S.Logo src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=405&height=141" />
      <S.Content>
        <S.ProductList>
          {Object.keys(data.products).map((item) => (
            <S.Product key={item} onClick={() => handleSelectProduct(item)}>
              <S.ProductImage src="http://localhost/an4log_inventory/items/weapon_assaultrifle.png" />
              <S.ProductTitle>{data.products[item].name}</S.ProductTitle>
            </S.Product>
          ))}
        </S.ProductList>
        <S.ProductMaterials>
          {product.name ? (
            <S.Form>
              <S.Title>
                Produção de <span>{data.title}</span>
              </S.Title>
              <S.HeaderProduction>
                <S.ProductionImage src="http://localhost/an4log_inventory/items/weapon_assaultrifle.png" />
                <S.Description>
                  <S.ProductionTitle>{product.name}</S.ProductionTitle>
                  <S.QtdPerProduction>{amount} unidade(s)</S.QtdPerProduction>
                </S.Description>
              </S.HeaderProduction>
              <S.Materials>
                {Object.keys(product.materials).map((item) => (
                  <Input
                    key={item}
                    label={`${product.materials[item].name}:`}
                    disabled
                    value={product.materials[item].amount * amount}
                  />
                ))}
              </S.Materials>
              <S.Actions>
                <Input
                  type="number"
                  label="Quantidade:"
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                />
                <S.Button onClick={handleProduction} disabled={blockProduction}>
                  Produzir
                </S.Button>
              </S.Actions>
            </S.Form>
          ) : (
            <S.EmptyProduct>Selecione um produto para produzir!</S.EmptyProduct>
          )}
        </S.ProductMaterials>
      </S.Content>
    </S.Container>
  );
}

export default Production;
