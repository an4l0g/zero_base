import React from "react";
import { usePreview } from "react-dnd-preview";
import ContentItem from "../ContentItem";

function DragPreview() {
  const preview = usePreview();
  if (!preview.display) return null;
  const { item, style } = preview;
  return <ContentItem isPreview={true} style={style} item={item} />;
}

export default DragPreview;
