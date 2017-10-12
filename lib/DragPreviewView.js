// @flow

import * as React from "react";
import { requireNativeComponent } from "react-native";

const DragPreviewViewNative = requireNativeComponent("MODragPreviewView", null);

export type Props = {
  children?: React.Node | React.Node[]
};

export default function DragPreviewView(props: Props) {
  const { children, ...rest } = props;
  return (
    <DragPreviewViewNative {...rest} style={{ position: "absolute" }}>
      {children}
    </DragPreviewViewNative>
  );
}
