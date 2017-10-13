// @flow

import * as React from "react";
import { requireNativeComponent, Platform } from "react-native";

import DragPreviewView from "./DragPreviewView";

const DragViewNative = requireNativeComponent("MODragView", null);

type _BaseProps = {
  children?: React.Node | React.Node[]
};
type _DataProps = { dragItem: string } | { dragItems: string[] };
export type Props = _BaseProps & _DataProps;

export default class DragView extends React.Component {
  static Preview = DragPreviewView;

  props: Props;

  render() {
    // $FlowExpectedError Flow doesn't like that we are getting both the dragItem and dragItems, but we need to get both to handle both cases
    let { children, dragItem, dragItems, ...rest } = this.props;

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

    // If we have a dragItem prop, convert that to an array and pass it to
    // the native view as dragItems. Otherwise, just use the dragItems we
    // were passed. Error if both of neither were passed
    if ((dragItem && dragItems) || (!dragItem && !dragItems)) {
      console.warn(
        "RNDragDrop must have either a dragItem or dragItems prop, but not both"
      );
      return null;
    }
    if (dragItem) {
      dragItems = [dragItem];
    }

    // Finally, return the view with the child inside it
    return (
      <DragViewNative {...rest} dragItems={dragItems}>
        {children}
      </DragViewNative>
    );
  }
}
