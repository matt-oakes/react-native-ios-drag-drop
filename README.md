
# `react-native-ios-drag-drop`
Support for the iOS 11+ drag and drop API in React Native.

## Installation

`yarn add react-native-ios-drag-drop` or `npm install react-native-ios-drag-drop --save`

### Mostly automatic installation

`react-native link react-native-ios-drag-drop`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-ios-drag-drop` and add `MOReactNativeIosDragDrop.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libMOReactNativeIosDragDrop.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<


## `DragView`
The `DragView` allows you to make one of your React views draggable. A `DragView` has the same behaviour as a `View` except for it accepts a `dragItem` or `dragItems` prop (it must have _exactly_ one of these props).

When used on an iOS 11+ iPad it will allow the user to long press on the view and drag it to a location which supports dropping (even across apps when used in multitasking mode).

You can provide one drag item (`dragItem`) or multiple drag items (`dragItems`) and even customise the preview with any React view you like.

### Usage

With a single drag item:
```babel
import { DragView } from 'react-native-ios-drag-drop';

export default function() {
  return (
    <DragView dragItem="Shared text">
      <Text>Draggable with a single item</Text>
    </DragView>
  );
}
```

With a multiple drag items:
```babel
import { DragView } from 'react-native-ios-drag-drop';

export default function() {
  return (
    <DragView dragItems={["First item", "Second item"]}>
      <Text>Draggable with multiple drag items</Text>
    </DragView>
  );
}
```

With a URL drag items:
```babel
import { DragView } from 'react-native-ios-drag-drop';

export default function() {
  return (
    <DragView dragItem="https://mattoakes.net">
      <Text>Draggable with a URL</Text>
    </DragView>
  );
}
```

With a custom preview view:
```babel
import { DragView } from 'react-native-ios-drag-drop';

export default function() {
  return (
    <DragView dragItem="Custom preview">
      <Text>Draggable with a custom preview</Text>
      <DragView.Preview>
        <Text>Custom preview</Text>
      </DragView.Preview>
    </DragView>
  );
}
```

## `DropView`

*Not yet implemented*