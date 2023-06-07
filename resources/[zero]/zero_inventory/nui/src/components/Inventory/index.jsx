import useBags from "../../hooks/useBags";
import Bag from "../Bag";
import Weapons from "../Weapons";
import Hotbar from "../Hotbar";
import DragPreview from "../Item/DragPreview";
import * as S from "./styles";

function Inventory() {
  const { bag, chest, maxSlots } = useBags();

  return (
    <S.Container>
      <DragPreview />
      <Hotbar />
      {chest.bag_type === "ground" && <Weapons />}
      <Bag
        bagType={bag.bag_type}
        title={bag.title}
        slotsAmount={maxSlots}
        slots={bag.slots}
        capacity={bag.max_weight}
        dropType={"bag"}
      />
      <Bag
        bagType={chest.bag_type}
        title={chest.title}
        slotsAmount={maxSlots}
        slots={chest.slots}
        capacity={chest.max_weight}
        dropType={"chest"}
        lootId={chest.id}
      />
    </S.Container>
  );
  3;
}

export default Inventory;
