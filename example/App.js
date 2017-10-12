// @flow

import React, { Component } from "react";
import { Platform, StyleSheet, Text, View } from "react-native";
import { DragView } from "react-native-ios-drag-drop";

export default class App extends Component<{}> {
  render() {
    return (
      <View style={styles.container}>
        <DragView
          style={styles.draggable}
          dragItem="This will be shared when dropped"
        >
          <View>
            <Text style={styles.title}>Draggable with single item</Text>
            <Text style={styles.details}>
              Will share "Shared text" when dropped.
            </Text>
          </View>
        </DragView>

        <DragView
          style={styles.draggable}
          dragItems={["First item", "Second item"]}
        >
          <View>
            <Text style={styles.title}>Draggable with multiple item</Text>
            <Text style={styles.details}>
              Will share "First item" and "Second item" when dropped.
            </Text>
          </View>
        </DragView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "flex-start",
    padding: 32
  },
  draggable: {
    backgroundColor: "#F5FCFF",
    borderRadius: 16,
    padding: 16,
    marginVertical: 16
  },
  title: {
    fontSize: 20,
    textAlign: "center",
    margin: 10
  },
  details: {
    textAlign: "center",
    color: "#333333",
    marginBottom: 5
  }
});
