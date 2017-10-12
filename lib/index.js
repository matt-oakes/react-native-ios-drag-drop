// @flow

import * as React from "react";
import { requireNativeComponent } from "react-native";

const RNDragDropNative = requireNativeComponent("RNDragDrop", null);

type Props = {
  children?: React.Node | React.Node[]
};

export default function RNDragDrop(props: Props) {
  console.log("props", props);
  const { children, ...rest } = props;

  if (!children || (Array.isArray(children) && children.length !== 1)) {
    console.warn("RNDragDrop must have exactly one child component");
    return null;
  }

  return <RNDragDropNative {...rest}>{children}</RNDragDropNative>;
}
