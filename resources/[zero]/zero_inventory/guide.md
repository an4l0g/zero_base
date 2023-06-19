## **[Server Exported Function]** tryToAddItem

_Verificar se a bag do player possui espaço e caso possua, adiciona o item na bag. Retorna `true` em caso de sucesso e `false` caso não consiga adicionar._

```lua
    exports.zero_inventory:tryToAddItem(source, user_id, index_item, amount)
```

<br />

## **[Server Exported Function]** addItem

_Adiciona um item na bag do player sem verificar se possui espaço._

```lua
    exports.zero_inventory:addItem(source, user_id, index_item, amount)
```

<br />

## **[Server Exported Function]** getItemAmount

_Retorna quantos itens o player tem na bag de acordo com o index informado._

```lua
    exports.zero_inventory:getItemAmount(source, user_id, index_item)
```

<br />

## **[Server Exported Function]** tryToRemoveItem

_Remove um item do inventário do player caso ele possua. Em caso de sucesso retorna `true` e caso o player não tenha o item ou a quantidade retorna `false`._

```lua
    exports.zero_inventory:tryToRemoveItem(source, user_id, index_item, amount)
```

<br />

## **[Server Exported Function]** getBagMaxWeight

_Retorna quantos KGs o player pode carregar na mochila._

```lua
    exports.zero_inventory:getBagMaxWeight(source, user_id)
```

<br />

## **[Server Exported Function]** getBagCurrentWeight

_Retorna quantos KGs o player está carregando._

```lua
    exports.zero_inventory:getBagCurrentWeight(source, user_id)
```

<br />

## **[Server Exported Function]** deleteBag

_Deletar o inventário do player._

```lua
    exports.zero_inventory:deleteBag(source, user_id, bag_type)
```

<br />

## **[Server Exported Function]** setBagMaxWeight

_Seta quantos KGs o player pode carregar na mochila._

```lua
    exports.zero_inventory:setBagMaxWeight(source, user_id, weight)
```

<br />

## **[Server Exported Function]** getPlayerBag

_Retorna todos os itens da mochila do player._

```lua
    exports.zero_inventory:getPlayerBag(source, user_id)
```

<br />

## **[Client event]** inventory:enableActions

_Habilita o player para poder executar novas ações no inventário._

```lua
    TriggerClientEvent('inventory:enableActions', source)
```

<br />

## **[Client event]** inventory:disableActions

_Desabilita o player para poder executar novas ações no inventário._

```lua
    TriggerClientEvent('inventory:disableActions', source)
```

<br />

## **[Client event]** inventory:close

_Fecha o inventário._

```lua
    TriggerClientEvent('inventory:close', source)
```
