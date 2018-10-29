/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */
import React, { Component } from 'react'
import { View, Image, TouchableHighlight, Text, StyleSheet } from 'react-native'
import Detail from './Detail'

class Test extends Component {
  constructor (...args) {
    super(...args)
  }

  render() {
    return (

      <View style={styles.container}>
      <TouchableHighlight style={{flex: 2, marginTop: 17}}
        underlayColor={'#333333'}
        onPress={() => {
          this.props.navigator.push({// 活动跳转，以Navigator为容器管理活动页面
            component: Detail,
          })
        }}>
        <View style={styles.content}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
        </View>
      </TouchableHighlight>

      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

module.exports = Test
