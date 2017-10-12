// @flow

import * as React from "react";
import { requireNativeComponent, Platform } from "react-native";

const RNDragDropNative = requireNativeComponent("RNDragDrop", null);

type Props = {
  children?: React.Node | React.Node[]
};

export default function RNDragDrop(props: Props) {
  const { children, ...rest } = props;

  // Ensure that we are on iOS 11+
  let validPlatform = false;
  if (Platform.OS === "ios") {
    const majorVersionIOS = parseInt(Platform.Version, 10);
    if (majorVersionIOS >= 11) {
      validPlatform = true;
    }
  }
  if (!validPlatform) {
    console.warn("RNDragDrop can only be used on iOS 11+");
    return null;
  }

  // Ensure that a single child has been given
  if (!children || (Array.isArray(children) && children.length !== 1)) {
    console.warn("RNDragDrop must have exactly one child component");
    return null;
  }

  return <RNDragDropNative {...rest}>{children}</RNDragDropNative>;
}
